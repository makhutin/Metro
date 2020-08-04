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
    func didTapOnPoint(_ view: UIView, info: MetroStationInfo)
}

protocol MetroViewProtocol: FromToViewControllerDelegate {
    func restoreMapToDefault()
    var contentScaleFactor: CGFloat { get set }
    var delegate: MetroVieweDelagate? { get set }
    var frame: CGRect { get set }
}

@IBDesignable
class MetroView: UIView, MetroViewProtocol {

    private var isSetup = false
    private var isStationSetup = false
    private var widthCoficent: CGFloat = 0.0
    private var heightCoficent: CGFloat = 0.0
    private let offsetMapXY: CGFloat = 450
    private let fromToWidth:CGFloat = 260
    private let pointSize: CGFloat = 20
    private let aPointView = MarkerView()
    private let bPointView = MarkerView()
    private var lastPoint: MetroDonatOne?

    var presenter: MetroViewPresenterProtocol!
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
        for elem in [self.aPointView, self.bPointView] {
            self.addSubview(elem)
            elem.isHidden = true
        }
        isSetup = true
    }
    

    func pointSetup() {
        aPointView.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
        bPointView.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
        aPointView.layer.shadowColor = UIColor.black.cgColor
        aPointView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bPointView.word = .b
        bPointView.layoutIfNeeded()
    }
    
    //Draw multistations border on map
    func multiStationsInit() {
        presenter?.multiStations.forEach {
            let view = MultiStationView()
            let x = $0.coords.x * widthCoficent + offsetMapXY
            let y = $0.coords.y * widthCoficent + offsetMapXY
            view.frame.origin = CGPoint(x: x, y: y)
            view.frame.size = CGSize(width: pointSize * 2, height: pointSize * 2)
            view.stationCount = StationCountForMulti(rawValue: $0.id.count) ?? .two
            self.addSubview(view)
        }
    }
    
    //Draw on map all stations, points and names
    func stationsInit() {
        //stations dot and text add to subviews
        presenter?.stations.forEach { elem in
            let (id,station) = elem
            let view = MetroDonatOne()
            view.id = id
            
            let x = station.coords.x * widthCoficent + offsetMapXY
            let y = station.coords.y * widthCoficent + offsetMapXY
            view.frame.origin = CGPoint(x: x, y: y)
            
            view.frame.size = CGSize(width: pointSize, height: pointSize)
            view.delegate = self
            
            var text = TextStationView()
            text.text = station.name["ru_RU"] ?? ""
            text.id = id
            text.delegate = self

            text = fineTuningText(id: text.id, text: text, view: view)
            //set color if text is text of multi station
            if let color = presenter.getColorForLine(withStation: id) {
                view.donatColor = color
                text.color = presenter.multiStationsId.contains(id) ? color : .black
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
    
    func stationConnectInit() {
        let multiCoords = presenter!.multiCoords
        presenter?.lines.forEach {
            let coords = coordsForLinesInit(LineBetweenStationsList: $0, multiCoords: multiCoords)
            let line = $0
            for (index,elem) in coords.enumerated() {
                let way = StationConnectionView(coords: elem)
                way.frame.size = self.frame.size
                way.fromId = line[index].fromId
                way.toId = line[index].toId
                self.addSubview(way)
            }
        }
    }
    
    
    func coordsForLinesInit(LineBetweenStationsList: [LineBetweenStations], multiCoords: [Int:CGPoint]) -> [CoordsBetweenStationsWithColor] {
        var result:[CoordsBetweenStationsWithColor] = []
        
        for connect in LineBetweenStationsList {
            let stations = presenter.stations
            let fromStationPoint = stations[connect.fromId]!.coords
            var fromCoords = CGPoint(x: fromStationPoint.x * widthCoficent + pointSize / 2 + offsetMapXY,
                                     y: fromStationPoint.y * heightCoficent + pointSize / 2 + offsetMapXY)
            if stations[connect.fromId]!.multi {
                let x = multiCoords[connect.fromId]!.x * widthCoficent + pointSize + 4
                var y = multiCoords[connect.fromId]!.y * heightCoficent + pointSize / 2
                if [28,57,63].contains(connect.fromId) {
                    y = multiCoords[connect.fromId]!.y * heightCoficent + pointSize
                }
                fromCoords = CGPoint(x: x + offsetMapXY, y: y + offsetMapXY)
            }
            let toStationPoint = stations[connect.toId]!.coords
            var toCoords = CGPoint(x: toStationPoint.x * widthCoficent + pointSize / 2 + offsetMapXY,
                                   y: toStationPoint.y * heightCoficent + pointSize / 2 + offsetMapXY)
            if stations[connect.toId]!.multi {
                let x = multiCoords[connect.toId]!.x * widthCoficent + pointSize + 4
                var y = multiCoords[connect.toId]!.y * heightCoficent + pointSize / 2
                if [28,57,63].contains(connect.toId) {
                    y = multiCoords[connect.toId]!.y * heightCoficent + pointSize
                }
                toCoords = CGPoint(x: x + offsetMapXY, y: y + offsetMapXY)
            }
            let color = presenter.getColorForLine(withStation: connect.toId) ?? UIColor.black
            result.append(CoordsBetweenStationsWithColor(fromCoords: fromCoords, toCoords: toCoords, color: color))
        }
        return result
    }
    
    

//MARK: draw stations
    
    /**
     draw station way on metro view map
     
     draw station way on metro view map.Scale point station on map , if it on the way.
     Unscale and make transparent point station, if it not in the way
     
     */
    func drawStationWayOnMap(){
            
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
    
    func setMarker(wordAorB: MarkerViewWord ) {
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

extension MetroView: FromToViewControllerDelegate {
    func fromToViewController(_ fromToViewController: FromToViewController, didTapButton buttonType: FromToButtonType, stationID id: Int) {
        //I hope, i will have time to refactor MetroView and all app :)
        let type = buttonType == .to ? MarkerViewWord.b : .a
        self.presenter?.setFromToPoint(buttonType: buttonType, stationID: id)

        self.drawStationWayOnMap()
        self.setMarker(wordAorB: type)
    }

    func fromToViewControllerWillCancel(_ fromToViewController: FromToViewController) {
        self.lastPoint?.setStyle(style: .normal)
    }
}

extension MetroView: MetroDonatOneDelegate{
    
    @objc func tapOnDonat(sender: MetroDonatOne) {
        if let donat = presenter?.findCurrentPoint() {
            donat.setStyle(style: .untap)
        }
        self.lastPoint = sender
        presenter?.tapOnDonat(sender: sender)
        sender.setStyle(style: .tap)
        let info = self.presenter.getInfoForID(id: sender.id)
        self.delegate?.didTapOnPoint(self, info: info)
    }
    
}

extension MetroView: TextStationViewDelegate {
    @objc func pressTextStation(sender: TextStationView) {
        let result = subviews.filter {
            guard let elem = $0 as? MetroDonatOne, elem.id == sender.id else { return false}
            return true
        }
        if let donat = result.first as? MetroDonatOne {
            tapOnDonat(sender: donat)
        }
    }
}

