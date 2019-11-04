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
    private var size: CGFloat = 20
    
    private var widthCoficent: CGFloat = 0.0
    private var heightCoficent: CGFloat = 0.0
    private let metroPositionX: CGFloat = 450
    private let metroPositionY: CGFloat = 450
    
    private var stationsConfig = MetroConfig.share.allStations
    private var linesConfig = MetroConfig.share.lines
    private var textConfig = MetroConfig.share.textStation["ru_RU"]!
    private let multiConfig = MetroConfig.share.multiStation
    
    
    private var viewSations: [MetroDonatOne] = []
    private var stationConnectView: [StationConnectionView] = []
    private var textView: [TextStationView] = []
    private let fromTo = FromToButtons()
    
    
    private var fromToWidth:CGFloat = 260
    
    private var aPoint: Int?
    private var bPoint: Int?
    
    private let aPointView = MarkerView()
    private let bPointView = MarkerView()
    private let pointSize: CGFloat = 40
    
    private var currentId: Int?

    
    var delegate: MetroVieweDelagate?
    

    
    override func layoutSubviews() {
        
        widthCoficent = self.frame.width / 200
        heightCoficent = self.frame.height / 200
        
        
        super.layoutSubviews()
        
        if isSetup { return }
        presenter = MetroViewPresenter(bind: self)
        pointSetup()
        stationConnectInit()
        stationsInit()
        for elem in [aPointView,bPointView,fromTo] {
            self.addSubview(elem)
            elem.isHidden = true
        }
        fromTo.delegate = self
        isSetup = true
    }
    
    private func pointSetup() {
        aPointView.frame.size = presenter!.sizeForMarker
        bPointView.frame.size = presenter!.sizeForMarker
        aPointView.layer.shadowColor = UIColor.black.cgColor
        aPointView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bPointView.word = .b
        bPointView.layoutIfNeeded()
        fromTo.frame.size = CGSize(width: fromToWidth / contentScaleFactor, height: 40)
    }
    
    
    //Draw on map all stations, points and names
    private func stationsInit() {
        //Multi stations add to subviews
        presenter?.getMultiStationsViews().forEach({
            self.addSubview($0)
        })
        //add text name stations or point
        presenter?.getTextAndDonatViews().forEach {
            switch $0 {
            case is MetroDonatOne:
                viewSations.append($0 as! MetroDonatOne)
            case is TextStationView:
                textView.append($0 as! TextStationView)
            default:
                break
            }
            self.addSubview($0)
        }
        
    }


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
    
    
    /**
     draw station way on metro view map
     
     draw station way on metro view map.Scale point station on map , if it on the way.
     Unscale and make transparent point station, if it not in the way
     
     */
    private func drawStationWayOnMap(){
            
        let stationsId = presenter!.getStationRoute
        if !stationsId.isEmpty {
            print(stationsId)
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
        unSetMarker()
        presenter?.restoreMapToDefault()
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
    
    
}


//station connect
extension MetroView {
    
    
    private func stationConnectInit() {
        for elem in 0..<linesConfig.count {
            let coords = coordsForLinesInit(LineBetweenStationsList: linesConfig[elem]!)
            for index in 0..<coords.count {
                let way = StationConnectionView(coords: coords[index],size: self.frame.size)
                way.frame.size = self.frame.size
                way.fromId = linesConfig[elem]![index].fromId
                way.toId = linesConfig[elem]![index].toId
                stationConnectView.append(way)
                self.addSubview(way)
                self.sendSubviewToBack(way)
                
            }
        }
    }
    
    
    private func coordsForLinesInit(LineBetweenStationsList: [LineBetweenStations]) -> [CoordsBetweenStationsWithColor] {
        var result:[CoordsBetweenStationsWithColor] = []
        var mulitCoords: [Int:CGPoint] = [:]
        for elem in multiConfig {
            for point in elem.id {
                mulitCoords.updateValue(elem.coords, forKey: point)
            }
        }
        for connect in LineBetweenStationsList {
            var fromCoords = CGPoint(x: stationsConfig[connect.fromId]!.coords.x * widthCoficent + size / 2 + metroPositionX,
                                     y: stationsConfig[connect.fromId]!.coords.y * heightCoficent + size / 2 + metroPositionY)
            if stationsConfig[connect.fromId]!.multi {
                let x = mulitCoords[connect.fromId]!.x * widthCoficent + size + 4
                var y = mulitCoords[connect.fromId]!.y * heightCoficent + size / 2
                if [28,57,63].contains(connect.fromId) {
                    y = mulitCoords[connect.fromId]!.y * heightCoficent + size
                }
                fromCoords = CGPoint(x: x + metroPositionX, y: y + metroPositionY)
            }
            var toCoords = CGPoint(x: stationsConfig[connect.toId]!.coords.x * widthCoficent + size / 2 + metroPositionX,
                                   y: stationsConfig[connect.toId]!.coords.y * heightCoficent + size / 2 + metroPositionY)
            if stationsConfig[connect.toId]!.multi {
                let x = mulitCoords[connect.toId]!.x * widthCoficent + size + 4
                var y = mulitCoords[connect.toId]!.y * heightCoficent + size / 2
                if [28,57,63].contains(connect.toId) {
                    y = mulitCoords[connect.toId]!.y * heightCoficent + size
                }
                toCoords = CGPoint(x: x + metroPositionX, y: y + metroPositionY)
            }
            
            result.append(CoordsBetweenStationsWithColor(fromCoords: fromCoords, toCoords: toCoords, color: stationsConfig[connect.toId]!.color))
        }
        return result
    }
    
    
}


//donat or point



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
//        sender.layer.contentsScale = 2
//        sender.unScale()
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
//Marker View
extension MetroView {
    

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
                    pointView.frame.origin = CGPoint(x: elem.frame.midX - pointSize / 2,
                                                     y: elem.frame.midY - pointSize * 2)
                    pointView.color = elem.donatColor
                    
                    UIView.animate(withDuration: 0.6, animations: {
                        pointView.layer.opacity = 1
                        pointView.frame.origin = CGPoint(x: elem.frame.midX - self.pointSize / 2,
                                                         y: elem.frame.midY - self.pointSize)
                        pointView.frame.size = CGSize(width: pointView.frame.width, height: pointView.frame.width)
                    })
            }
        }
    }
    
    private func unSetMarker() {
        aPointView.layer.opacity = 0
        bPointView.layer.opacity = 0
    }
    
}
