//
//  MetroView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

@IBDesignable
class MetroView: UIView {
    
    var isSetup = false
    var isStationSetup = false
    var size: CGFloat = 20
    
    var widthCoficent: CGFloat = 0.0
    var heightCoficent: CGFloat = 0.0
    
    var stationsConfig: [MetroStation] = MetroConfig.share.allStations
    var viewSations: [MetroDonatOne] = []
    
    
    override func layoutSubviews() {
        widthCoficent = self.frame.width / 100
        heightCoficent = self.frame.height / 100
        super.layoutSubviews()
        sationsInit()
        if isSetup { return }
        
    }
    
    private func sationsInit() {
        for station in stationsConfig {
            let view = MetroDonatOne()
            let x = station.coords.x * widthCoficent
            let y = station.coords.y * heightCoficent
            view.frame.origin = CGPoint(x: x, y: y)
            view.donatColor = station.color
            view.frame.size = CGSize(width: size, height: size)
            if isStationSetup { continue }
            viewSations.append(view)
            self.addSubview(view)
        }
        isStationSetup = true
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
