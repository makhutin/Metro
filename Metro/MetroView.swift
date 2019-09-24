//
//  MetroView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol MetroVieweDelagate {
    func drawStationPath(sender: MetroView)
}

@IBDesignable
class MetroView: UIView {
    
    private var isSetup = false
    private var isStationSetup = false
    private var size: CGFloat = 20
    
    private var widthCoficent: CGFloat = 0.0
    private var heightCoficent: CGFloat = 0.0
    
    private var stationsConfig = MetroConfig.share.allStations
    private var linesConfig = MetroConfig.share.lines
    
    private var viewSations: [MetroDonatOne] = []
    private var stationConnectView: [StationConnectionView] = []
    private let fromTo = FromToButtons()
    
    private var aPoint: Int?
    private var bPoint: Int?
    
    private let aPointView = MarkerView()
    private let bPointView = MarkerView()
    private let pointSize: CGFloat = 40
    
    private var currentId: Int?
    
    var delegate: MetroVieweDelagate?
    

    
    
    override func layoutSubviews() {
        
        widthCoficent = self.frame.width / 100
        heightCoficent = self.frame.height / 100
        
        aPointView.frame.size = CGSize(width: pointSize, height: pointSize)
        bPointView.frame.size = CGSize(width: pointSize, height: pointSize)
        
        bPointView.word = "B"
        bPointView.layoutIfNeeded()
        
        super.layoutSubviews()
        if isSetup { return }
        stationConnectInit()
        fromTo.frame.size = CGSize(width: fromTo.width * 2 + 5, height: fromTo.height)
        stationsInit()
        for elem in [aPointView,bPointView,fromTo] {
            self.addSubview(elem)
            elem.isHidden = true
        }
        fromTo.delegate = self
        isSetup = true
    }
    
    /**
     draw sation on the mapview
     
     draw all point station on th emap view
     */
    private func stationsInit() {
        for station in stationsConfig {
            let view = MetroDonatOne()
            view.id = station.id
            let x = station.coords.x * widthCoficent
            let y = station.coords.y * heightCoficent
            view.frame.origin = CGPoint(x: x, y: y)
            view.donatColor = station.color
            view.frame.size = CGSize(width: size, height: size)
            if isStationSetup { continue }
            viewSations.append(view)
            view.delegate = self
            self.addSubview(view)
        }
        isStationSetup = true
    }


    /**
     start if tap on the map view
     
     When press on map view, current point unfocus and fromto window hide
     
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let donat = findCurrentDonat() {
            unScaleDonat(donat: donat)
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
            
            delegate?.drawStationPath(sender: self)
            
            let stations = MetroConfig.share.findEnd(start: a, end: b)
            
            // hide or unhide stations point
            for elem in viewSations {
                if stations.contains(elem.id) {
                    elem.donatColor = elem.donatColor.withAlphaComponent(1)
                    elem.layoutSubviews()
                    scaleDonat(donat: elem)
                }else{
                    elem.donatColor = elem.donatColor.withAlphaComponent(0.3)
                    elem.layoutSubviews()
                    unScaleDonat(donat: elem)
                }
            }
            // hide or unhide lines between points
            for connect in stationConnectView {
                if stations.contains(connect.toId) && stations.contains(connect.fromId) {
                    connectionHide(hide: false, stationConnectView: connect)
                }else{
                    connectionHide(hide: true, stationConnectView: connect)
                }
            }
            
            
        }
    }
    
    func restoreMapToDefault() {
        for elem in stationConnectView {
            connectionHide(hide: false, stationConnectView: elem)
        }
        
        for elem in viewSations {
            unScaleDonat(donat: elem)
            elem.donatColor = elem.donatColor.withAlphaComponent(1)
            elem.layoutSubviews()
        }
        
        unSetMarker()
        
        bPoint = nil
        aPoint = nil
        
        
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
        for connect in LineBetweenStationsList {
            let fromCoords = CGPoint(x: stationsConfig[connect.fromId - 1].coords.x * widthCoficent + size / 2,
                                     y: stationsConfig[connect.fromId - 1].coords.y * heightCoficent + size / 2)
            let toCoords = CGPoint(x: stationsConfig[connect.toId - 1].coords.x * widthCoficent + size / 2,
                                   y: stationsConfig[connect.toId - 1].coords.y * heightCoficent + size / 2)
            result.append(CoordsBetweenStationsWithColor(fromCoords: fromCoords, toCoords: toCoords, color: stationsConfig[connect.toId - 1].color))
        }
        return result
    }
    
    private func connectionHide(hide: Bool, stationConnectView: StationConnectionView) {
        switch hide {
        case true:
            UIView.animate(withDuration: 0.6, animations: {
                stationConnectView.layer.opacity = 0.3
                stationConnectView.layoutIfNeeded()
            })
        case false:
            UIView.animate(withDuration: 0.6, animations: {
                stationConnectView.layer.opacity = 1
                stationConnectView.layoutIfNeeded()
            })
        }
    }
    
}


//donat or point
extension MetroView {
    
    
    /**
     find current donat in view list
     
     :returns: MetroDonat? return nil or current view station.
     */
    private func findCurrentDonat() -> MetroDonatOne? {
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
    
    
    /**
     scale point view station
     
     scale point view station
     
     :donat:  MetroDonatOne -  sclae this point.
     
     */
    private func scaleDonat(donat:MetroDonatOne) {
        if !donat.scaled{
            let scaleValue:CGFloat = 5
            UIView.animate(withDuration: 0.6, animations: {
                donat.frame.origin = CGPoint(x: donat.frame.origin.x - scaleValue / 2,
                                             y: donat.frame.origin.y - scaleValue / 2)
                donat.frame.size = CGSize(width: donat.frame.size.width + scaleValue,
                                          height: donat.frame.size.height + scaleValue)
                self.layoutIfNeeded()
            })
            donat.scaled = true
        }
        
    }
    
    /**
     unscale point view station
     
     unscale point view station
     
     :donat:  MetroDonatOne -  unsclae this point.
     
     */
    private func unScaleDonat(donat:MetroDonatOne) {
        if donat.scaled {
            
            let scaleValue:CGFloat = 5
            UIView.animate(withDuration: 0.6, animations: {
                donat.frame.origin = CGPoint(x: donat.frame.origin.x + scaleValue / 2,
                                             y: donat.frame.origin.y + scaleValue / 2)
                donat.frame.size = CGSize(width: donat.frame.size.width - scaleValue,
                                          height: donat.frame.size.height - scaleValue)
                self.layoutIfNeeded()
            })
            donat.scaled = false
        }
        
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
    func tapOnDonat(sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        })
        if let donat = sender as? MetroDonatOne{
            if currentId == nil {
                currentId = donat.id
                donat.layer.contentsScale = 2
                scaleDonat(donat: donat)
            }else{
                if let donat = findCurrentDonat() {
                    unScaleDonat(donat: donat)
                }
                currentId = donat.id
                donat.layer.contentsScale = 2
                scaleDonat(donat: donat)
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

            var x = donat.centerX - fromTo.width - 12
            var y = donat.frame.origin.y - 40
            if donat.frame.origin.y - 50 < 0 {
                y = donat.frame.origin.y - fromTo.height / 2
                x = donat.frame.origin.x + donat.frame.width + 20
            }
            if x < 0 {
                y = donat.frame.origin.y - fromTo.height / 2
                x = donat.frame.origin.x + donat.frame.width + 20
            }
            if x + fromTo.frame.width > self.frame.width {
                x = donat.frame.origin.x - 20 - fromTo.frame.width
            }
            
            fromTo.frame.origin = CGPoint(x: x, y: y )
            UIView.animate(withDuration: 0.6, animations: {
                self.fromTo.layer.opacity = 1
                self.fromTo.isHidden = false
                self.layoutIfNeeded()
            })
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
            pointView.frame.size = CGSize(width: pointView.frame.width, height: self.pointSize * 2 )
            pointView.layoutIfNeeded()
            pointView.isHidden = false
            for elem in viewSations {
                if elem.id == point {
                    pointView.frame.origin = CGPoint(x: elem.centerX - pointSize / 2,
                                                      y: elem.centerY - pointSize * 1.1)
                    pointView.color = elem.donatColor
                    UIView.animate(withDuration: 0.6, animations: {
                        
                        pointView.layer.opacity = 1
                        pointView.frame.size = CGSize(width: pointView.frame.width, height: self.pointSize)
                        self.layoutIfNeeded()
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
