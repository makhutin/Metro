//
//  MarkerView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 23/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

enum MarkerViewWord {
    case a, b
}

@IBDesignable
class MarkerView: UIView {

    private var isSetup = false
    
    private var circle = UIView()
    private var whiteCircle = UIView()
    private var angle = UIView()
    
    var color:UIColor = .red
    private var text = UILabel()
    var word = "A"
    
    
    override func layoutSubviews() {
        let size = self.frame.width
        let whiteCircleSize = size / 8
        
        whiteCircle.backgroundColor = .white
        whiteCircle.frame = CGRect(x: size / 2 - whiteCircleSize / 2, y: size * 1.03,
                                   width: whiteCircleSize, height: whiteCircleSize)
        whiteCircle.layer.cornerRadius = whiteCircleSize / 2
        
        text.frame = CGRect(x: 0,
                            y: 0,
                            width: self.frame.width,
                            height:self.frame.height * 0.8)
        text.textAlignment = .center
        text.text = word
        text.font = UIFont(name: "Thonburi", size: round(self.frame.width) * 0.7)
        text.textColor = .white
        let angleSize:CGFloat = size * 40/150
        angle.frame = CGRect(x: self.frame.width / 2 - angleSize / 4,
                             y: self.frame.height / 2 + size / 6,
                             width: angleSize / 2,
                             height: angleSize + angleSize)
        angle.backgroundColor = self.color
        circle.frame = CGRect(x: self.frame.width / 2 - size / 2,
                              y: self.frame.height / 2 - size / 2,
                              width: size,
                              height: size)
        circle.backgroundColor = self.color
        circle.layer.cornerRadius = circle.frame.width / 2
        angle.layer.cornerRadius = angleSize
        angle.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        super.layoutSubviews()
        if isSetup { return }
        self.addSubview(whiteCircle)
        self.addSubview(circle)
        self.addSubview(angle)
        self.addSubview(text)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
