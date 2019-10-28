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
        aPointView.frame.size = CGSize(width: pointSize, height: pointSize)
        bPointView.frame.size = CGSize(width: pointSize, height: pointSize)
        
        aPointView.layer.shadowColor = UIColor.black.cgColor
        aPointView.layer.shadowOffset = CGSize(width: 2, height: 2)

        
        bPointView.word = .b
        bPointView.layoutIfNeeded()
        
        fromTo.frame.size = CGSize(width: fromToWidth / contentScaleFactor, height: 40)
    }
    
    
    /**
     draw sation on the mapview
     
     draw all point station on th emap view
     */
    private func stationsInit() {
        
        for multi in multiConfig {
            let view = MultiStationView()
            let x = multi.coords.x * widthCoficent + metroPositionX
            let y = multi.coords.y * heightCoficent + metroPositionY
            view.frame.origin = CGPoint(x: x, y: y)
            view.frame.size = CGSize(width: size * 2, height: size * 2)
            view.stationCount = multi.count
            self.addSubview(view)
            
        }
        
        for station in stationsConfig.values {
            // create dots "donats"
            let view = MetroDonatOne()
            view.id = station.id
            let x = station.coords.x * widthCoficent + metroPositionX
            let y = station.coords.y * heightCoficent + metroPositionY
            view.frame.origin = CGPoint(x: x, y: y)
            view.donatColor = station.color
            view.frame.size = CGSize(width: size, height: size)
            if isStationSetup { continue }
            
            viewSations.append(view)
            view.delegate = self
            self.addSubview(view)
            
            // text
            let text = TextStationView()
            text.text = textConfig[view.id] ?? ""
            text.id = view.id
            text.delegate = self
            text.layoutSubviews()
            
            //set text frame
            switch view.id {
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
            // set color for multi station
            switch view.id {
            case 7,8,9,10:
                text.color = stationsConfig[7]!.color
            case 27,28,29:
                text.color = stationsConfig[28]!.color
            case 43,44,45:
                text.color = stationsConfig[43]!.color
            case 54,56,57:
                text.color = stationsConfig[54]!.color
            case 62,63:
                text.color = stationsConfig[62]!.color
            default:
                text.color = .black
            }
            
            textView.append(text)
            self.addSubview(text)
        }
        isStationSetup = true
    }


    /**
     start if tap on the map view
     
     When press on map view, current point unfocus and fromto window hide
     
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let donat = findCurrentDonat() {
            donat.scale()
        }
        currentId = nil
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
        if let a = aPoint,let b = bPoint {
            
            
            
            let stations = RouteBuilder.share.buildPath(start: a, end: b)
            delegate?.drawStationPath(sender: self,data: stations)
            
            // hide or unhide stations point

            // hide or unhide lines between points
            for connect in stationConnectView {
                if stations.contains(connect.toId) && stations.contains(connect.fromId) {
                    connect.hide(false)
                }else{
                    connect.hide(true)
                    self.sendSubviewToBack(connect)
                }
            }
            
            for elem in viewSations {
                if stations.contains(elem.id) {
                    elem.hide(false)
                    elem.layoutSubviews()
                    elem.unScale()
                }else{
                    elem.hide(true)
                    elem.layoutSubviews()
                    elem.scale()
                }
            }
            
            for elem in textView {
                if stations.contains(elem.id) {
                    elem.hide(false)
                }else{
                    elem.hide(true)
                }
            }
            
        }
    }
    
    
    func restoreMapToDefault() {
        for elem in stationConnectView {
            elem.hide(false)
        }
        
        for elem in viewSations.reversed() {
            elem.scale()
            elem.donatColor = elem.donatColor.withAlphaComponent(1)
            elem.layoutSubviews()
        }

        for elem in textView {
            elem.hide(false)
        }
        unSetMarker()
        
        bPoint = nil
        aPoint = nil
    }
    
    func updateFromToScale() {
        if let donat = findCurrentDonat(){
            fromTo.chageStyle()
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
extension MetroView {
    
    
    /**
     find current donat in view list
     
     :returns: MetroDonat? return nil or current view station.
     */
    func findCurrentDonat() -> MetroDonatOne? {
        if let currentId = currentId {
            if currentId != aPoint && currentId != bPoint{
                for elem in viewSations {
                    if elem.id == currentId {
                        return elem
                    }
                }
            }
            
        }
        return nil
    }


}



extension MetroView: FromToButtonsDelegate{
    
    func pressToButton(sender: UIView) {
        bPoint = currentId
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
        aPoint = currentId
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

        if currentId == nil {
            currentId = sender.id
            sender.layer.contentsScale = 2
            sender.unScale()
        }else{
            if let oldDonat = findCurrentDonat() {
                oldDonat.scale()
            }
            currentId = sender.id
            sender.layer.contentsScale = 2
            sender.unScale()
        }
            //set from to point
            switch(aPoint,bPoint){
            case (nil,nil):
                fromTo.currentStyle = .from
            case (_,nil):
                fromTo.currentStyle = .to
            case (_,_):
                fromTo.currentStyle = .to
            }
            fromTo.chageStyle()
            updateFromToScale()
            delegate?.fromToButtonPress(sender: fromTo)
        
    }
    
}

extension MetroView: TextStationViewDelegate {
    func pressTextStation(sender: TextStationView) {
        for view in viewSations {
            if view.id == sender.id {
                tapOnDonat(sender: view)
            }
        }
    }
}
//Marker View
extension MetroView {
    

    private func setMarker(wordAorB: MarkerViewWord ) {
        var tempPoint: Int?
        var pointView: MarkerView
        switch wordAorB {
        case .a:
            pointView = aPointView
            tempPoint = aPoint
        case .b:
            pointView = bPointView
            tempPoint = bPoint
        }
        if let point = tempPoint {
            pointView.layer.opacity = 0
            pointView.isHidden = false
            viewSations.forEach {
                if $0.id == point {
                    let elem = $0
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
    }
    
    private func unSetMarker() {
        aPointView.layer.opacity = 0
        bPointView.layer.opacity = 0
    }
    
}
