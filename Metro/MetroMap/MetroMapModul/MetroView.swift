//
//  MetroView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol MetroVieweDelagate {
    func drawStationPath(sender: MetroView, data: [Int])
    func fromToButtonPress(sender: FromToButtons)
}

@IBDesignable
class MetroView: UIView {
    
    var presenter: MetroViewPresenterProtocol?
    
    private var isSetup = false
    private var isStationSetup = false
    
    private var widthCoficent: CGFloat = 0.0
    private var heightCoficent: CGFloat = 0.0
    private let offsetMapXY: CGFloat = 450
    private var fromToWidth:CGFloat = 260
    private let pointSize: CGFloat = 20
    
    private let fromTo = FromToButtons()
    private let aPointView = MarkerView()
    private let bPointView = MarkerView()

    var delegate: MetroVieweDelagate?
    

// MARK: Initialization
    override func layoutSubviews() {
        
        widthCoficent = self.frame.width / 200
        heightCoficent = self.frame.height / 200
        
        super.layoutSubviews()
        
        if isSetup { return }
        presenter = MetroViewPresenter(bind: self)
        pointSetup()
        stationConnectInit()
        multiStationsInit()
        stationsInit()
        for elem in [aPointView,bPointView,fromTo] {
            self.addSubview(elem)
            elem.isHidden = true
        }
        fromTo.delegate = self
        isSetup = true
    }
    

    private func pointSetup() {
        aPointView.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
        bPointView.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
        aPointView.layer.shadowColor = UIColor.black.cgColor
        aPointView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bPointView.word = .b
        bPointView.layoutIfNeeded()
        fromTo.frame.size = CGSize(width: fromToWidth / contentScaleFactor, height: 40)
    }
    
    //Draw multistations border on map
    private func multiStationsInit() {
        presenter?.multiStations.forEach {
            let view = MultiStationView()
            let x = $0.coords.x * widthCoficent + offsetMapXY
            let y = $0.coords.y * widthCoficent + offsetMapXY
            view.frame.origin = CGPoint(x: x, y: y)
            view.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
            view.stationCount = $0.count
            self.addSubview(view)
        }
    }
    
    //Draw on map all stations, points and names
    private func stationsInit() {
        //Multi stations add to subviews
        presenter?.stations.forEach { (arg) in
            let (_, elem) = arg
            let view = MetroDonatOne()
            view.id = elem.id
            let x = elem.coords.x * widthCoficent + offsetMapXY
            let y = elem.coords.y * widthCoficent + offsetMapXY
            view.frame.origin = CGPoint(x: x, y: y)
            view.donatColor = elem.color
            view.frame.size = CGSize(width: pointSize, height: pointSize)
            view.delegate = self
            
            var text = TextStationView()
            text.text = presenter?.text[elem.id] ?? ""
            text.id = elem.id
            text.delegate = self

            text = fineTuningText(id: text.id, text: text, view: view)
            if let presenter = presenter {
                text.color = presenter.multiStationsId.contains(text.id) ? presenter.stations[text.id]!.color : .black
            }
            self.addSubview(text)
            self.addSubview(view)
        }
    }
    
    //final correct for text
    func fineTuningText(id: Int, text: TextStationView, view: MetroDonatOne) -> TextStationView {
        text.layoutSubviews()
        switch id {
        case 4...8,28,46,63,64,50...53:
            text.frame = CGRect(x: view.frame.midX - text.frame.width - 16, y: view.frame.midY - 10, width: 150, height: 20)
            text.style = .right
        case 57,54,56,45,44:
            text.frame = CGRect(x: view.frame.midX + 6, y: view.frame.midY - 26, width: 150, height: 20)
            text.style = .left
        case 10:
            text.frame = CGRect(x: view.frame.midX - text.frame.width - 14, y: view.frame.midY + 5, width: 150, height: 20)
            text.style = .right
        case 29,9:
            text.frame = CGRect(x: view.frame.midX - text.frame.width - 8, y: view.frame.midY - 26, width: 150, height: 20)
            text.style = .right
        case 43:
            text.frame = CGRect(x: view.frame.midX + 30.3, y: view.frame.midY - 35, width: 150, height: 20)
            text.style = .left
        case 55:
            text.frame = CGRect(x: view.frame.midX - text.frame.width / 2, y: view.frame.midY + 5, width: 150, height: 20)
            text.style = .right
        default:
            text.frame = CGRect(x: view.frame.midX + 15, y: view.frame.midY - 10, width: 150, height: 20)
        }
        return text
    }
    
    private func stationConnectInit() {
        let multiCoords = presenter!.multiCoords
        presenter?.lines.forEach {
            let coords = coordsForLinesInit(LineBetweenStationsList: $0.value, multiCoords: multiCoords)
            let line = $0.value
            for (index,elem) in coords.enumerated() {
                
                let way = StationConnectionView(coords: elem,size: self.frame.size)
                way.frame.size = self.frame.size
                way.fromId = line[index].fromId
                way.toId = line[index].toId
                self.addSubview(way)
            }
        }
    }
    
    
    private func coordsForLinesInit(LineBetweenStationsList: [LineBetweenStations], multiCoords: [Int:CGPoint]) -> [CoordsBetweenStationsWithColor] {
        var result:[CoordsBetweenStationsWithColor] = []
        
        let stationsConfig = presenter!.stations
        
        for connect in LineBetweenStationsList {
            var fromCoords = CGPoint(x: stationsConfig[connect.fromId]!.coords.x * widthCoficent + pointSize / 2 + offsetMapXY,
                                     y: stationsConfig[connect.fromId]!.coords.y * heightCoficent + pointSize / 2 + offsetMapXY)
            if stationsConfig[connect.fromId]!.multi {
                let x = multiCoords[connect.fromId]!.x * widthCoficent + pointSize + 4
                var y = multiCoords[connect.fromId]!.y * heightCoficent + pointSize / 2
                if [28,57,63].contains(connect.fromId) {
                    y = multiCoords[connect.fromId]!.y * heightCoficent + pointSize
                }
                fromCoords = CGPoint(x: x + offsetMapXY, y: y + offsetMapXY)
            }
            
            var toCoords = CGPoint(x: stationsConfig[connect.toId]!.coords.x * widthCoficent + pointSize / 2 + offsetMapXY,
                                   y: stationsConfig[connect.toId]!.coords.y * heightCoficent + pointSize / 2 + offsetMapXY)
            if stationsConfig[connect.toId]!.multi {
                let x = multiCoords[connect.toId]!.x * widthCoficent + pointSize + 4
                var y = multiCoords[connect.toId]!.y * heightCoficent + pointSize / 2
                if [28,57,63].contains(connect.toId) {
                    y = multiCoords[connect.toId]!.y * heightCoficent + pointSize
                }
                toCoords = CGPoint(x: x + offsetMapXY, y: y + offsetMapXY)
            }
            
            result.append(CoordsBetweenStationsWithColor(fromCoords: fromCoords, toCoords: toCoords, color: stationsConfig[connect.toId]!.color))
        }
        return result
    }
    
    

//MARK: draw stations
    
    /**
     draw station way on metro view map
     
     draw station way on metro view map.Scale point station on map , if it on the way.
     Unscale and make transparent point station, if it not in the way
     
     */
    private func drawStationWayOnMap(){
            
        let stationsId = presenter!.getStationRoute
        if !stationsId.isEmpty {
            NSLog("route -- \(stationsId)")
            delegate?.drawStationPath(sender: self,data: stationsId)
            subviews.forEach {
                switch $0 {
                case let elem as MetroDonatOne:
                    elem.setStyle(style: stationsId.contains(elem.id) ? .route : .unroute)
                case let elem as TextStationView:
                    elem.setStyle(style: stationsId.contains(elem.id) ? .route : .unroute)
                case let elem as StationConnectionView:
                    if stationsId.contains(elem.toId) && stationsId.contains(elem.fromId){
                        elem.setStyle(style: .route)
                    }else{
                        elem.setStyle(style: .unroute)
                    }
                default:
                    break
                }
            }
        }
    }
    
    func updateFromToScale() {
        if let donat = presenter?.findCurrentPoint(){
            fromTo.chageStyle(style: .old)
            fromTo.frame.size.width = fromToWidth / contentScaleFactor
            let x = donat.frame.midX - fromTo.frame.width / 2
            let y = donat.frame.origin.y + 5
            fromTo.frame.origin = CGPoint(x: x, y: y )
            
            UIView.animate(withDuration: 0.4, animations: {
                self.fromTo.layer.opacity = 1
                self.fromTo.isHidden = false
                self.layoutSubviews()
            })
        }
    }
    
    private func setMarker(wordAorB: MarkerViewWord ) {
        var pointView: MarkerView
        switch wordAorB {
        case .a:
            pointView = aPointView
        case .b:
            pointView = bPointView
        }
        if let point = presenter?.getAorBPoint(point: wordAorB) {
            pointView.layer.opacity = 0
            pointView.isHidden = false
            subviews
                .filter{
                    guard let elem = $0 as? MetroDonatOne, elem.id == point else { return false }
                    return true
            }
                .forEach {
                    let elem = $0 as! MetroDonatOne
                    pointView.frame.size = CGSize(width: pointView.frame.width, height: pointView.frame.height / 2)
                    pointView.frame.origin = CGPoint(x: elem.frame.midX - pointSize ,
                                                     y: elem.frame.midY - pointSize * 4)
                    pointView.color = elem.donatColor
                    
                    UIView.animate(withDuration: 0.6, animations: {
                        pointView.layer.opacity = 1
                        pointView.frame.origin = CGPoint(x: elem.frame.midX - self.pointSize ,
                                                         y: elem.frame.midY - self.pointSize * 2)
                        pointView.frame.size = CGSize(width: pointView.frame.width, height: pointView.frame.width)
                    })
            }
        }
    }
    
    func restoreMapToDefault() {
        subviews.forEach{
            switch $0 {
            case let elem as MetroDonatOne:
                elem.setStyle(style: .normal)
            case let elem as TextStationView:
                elem.setStyle(style: .normal)
            case let elem as StationConnectionView:
                elem.setStyle(style: .normal)
            default:
                break
            }
        }
        aPointView.layer.opacity = 0
        bPointView.layer.opacity = 0
        presenter?.restoreMapToDefault()
    }
    
    
}



//MARK: taps
extension MetroView {
    /**
     start if tap on the map view
     
     When press on map view, current point unfocus and fromto window hide
     
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        presenter?.touchesEnded()
        UIView.animate(withDuration: 0.4, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        }, completion: { complite in
            self.fromTo.isHidden = true
        })
    }
}


extension MetroView: FromToButtonsDelegate{
    
    func pressToButton(sender: UIView) {
        presenter?.pressFromToButton(button: .to)
        
        UIView.animate(withDuration: 0.6, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        }, completion: { complite in
            self.fromTo.isHidden = true
        })
        
        drawStationWayOnMap()
        setMarker(wordAorB: .b)
    }
    
    func pressFromButton(sender: UIView) {
        presenter?.pressFromToButton(button: .from)
        
        UIView.animate(withDuration: 0.6, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        }, completion: { complite in
            self.fromTo.isHidden = true
        })
        
        drawStationWayOnMap()
        setMarker(wordAorB: .a)
    }
    
    
}



extension MetroView: MetroDonatOneDelegate{
    
    func tapOnDonat(sender: MetroDonatOne) {
        UIView.animate(withDuration: 0.4, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        })
        if let donat = presenter?.findCurrentPoint() {
            donat.setStyle(style: .untap)
        }
        presenter?.tapOnDonat(sender: sender)
        sender.setStyle(style: .tap)

        let style = presenter?.getStyleForFromToView
        fromTo.chageStyle(style: style!)
        updateFromToScale()
        delegate?.fromToButtonPress(sender: fromTo)
        
    }
    
}

extension MetroView: TextStationViewDelegate {
    func pressTextStation(sender: TextStationView) {
        let result = subviews.filter {
            guard let elem = $0 as? MetroDonatOne, elem.id == sender.id else { return false}
            return true
        }
        if let donat = result.first as? MetroDonatOne {
            tapOnDonat(sender: donat)
        }
    }
}

