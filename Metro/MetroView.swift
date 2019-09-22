//
//  MetroView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol MetroVieweDelagate {
    func donatIsChoise(id: Int)
}

@IBDesignable
class MetroView: UIView {
    
    var isSetup = false
    var isStationSetup = false
    var size: CGFloat = 20
    
    var widthCoficent: CGFloat = 0.0
    var heightCoficent: CGFloat = 0.0
    
    var stationsConfig: [MetroStation] = MetroConfig.share.allStations
    var viewSations: [MetroDonatOne] = []
    let fromTo = FromToButtons()
    
    var aPoint: Int?
    var bPoint: Int?
    
    var currentId:Int?
    
    
    override func layoutSubviews() {
        
        

        widthCoficent = self.frame.width / 100
        heightCoficent = self.frame.height / 100
        super.layoutSubviews()
        if isSetup { return }
        fromTo.frame.origin = CGPoint(x: 30, y: 30)
        fromTo.frame.size = CGSize(width: fromTo.width * 2 + 5, height: fromTo.height)
        sationsInit()
        self.addSubview(fromTo)
        fromTo.delegate = self
        isSetup = true
        
    }
    
    private func sationsInit() {
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
    
    func findCurrentDonat() -> MetroDonatOne? {
        if currentId != aPoint && currentId != bPoint{
            for elem in viewSations {
                if elem.id == currentId! {
                    return elem
                }
            }
        }
        return nil
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
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
    
    
    func drawStationWayOnMap(){
        if let a = aPoint,let b = bPoint {
            let stations = MetroConfig.share.findEnd(start: a, end: b)
            for elem in viewSations {
                if stations.contains(elem.id) {
                    scaleDonat(donat: elem)
                }else{
                    unScaleDonat(donat: elem)
                    
                }
            }
        }
    }
}

extension MetroView {
    
    func scaleDonat(donat:MetroDonatOne) {
        if !donat.scaled{
            let scaleValue:CGFloat = 10
            UIView.animate(withDuration: 0.4, animations: {
                donat.frame.origin = CGPoint(x: donat.frame.origin.x - scaleValue / 2,
                                             y: donat.frame.origin.y - scaleValue / 2)
                donat.frame.size = CGSize(width: donat.frame.size.width + scaleValue,
                                          height: donat.frame.size.height + scaleValue)
                self.layoutIfNeeded()
            })
            donat.scaled = true
        }
        
    }
    
    func unScaleDonat(donat:MetroDonatOne) {
        if donat.scaled {
            let scaleValue:CGFloat = 10
            UIView.animate(withDuration: 0.4, animations: {
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
        UIView.animate(withDuration: 0.4, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        }, completion: { complite in
            self.fromTo.isHidden = true
        })
        drawStationWayOnMap()
    }
    
    func pressFromButton(sender: UIView) {
        aPoint = currentId
        UIView.animate(withDuration: 0.4, animations: {
            self.fromTo.layer.opacity = 0
            self.layoutIfNeeded()
        }, completion: { complite in
            self.fromTo.isHidden = true
        })
        drawStationWayOnMap()
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
            UIView.animate(withDuration: 0.4, animations: {
                self.fromTo.layer.opacity = 1
                self.fromTo.isHidden = false
                self.layoutIfNeeded()
            })
            print("\(donat.id)")
        }
        
    }
}
