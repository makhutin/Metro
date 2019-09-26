//
//  TextStationView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 25/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol TextStationViewDelegate {
    func pressTextStation(sender: TextStationView)
}


@IBDesignable
class TextStationView: UIView {
    
    var isSetup = false
    var text:String = "достоевсая"
    var delegate:TextStationViewDelegate?
    var style:UIControl.ContentHorizontalAlignment = .left
    var color:UIColor = .black
    var id:Int = 0
    
    private let button = UIButton()
    private let fontSize:CGFloat = 7
    private let fontStyle:String = "GillSans-Bold"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let font = UIFont(name: fontStyle, size: fontSize)!
        
        
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        button.contentHorizontalAlignment = style
        button.frame = self.bounds
        button.sizeToFit()
        button.frame.origin = CGPoint(x: 0, y: 0)
        self.frame.size = button.frame.size
        
        
        if isSetup { return }
        self.addSubview(button)
        isSetup = true
        button.addTarget(self, action: #selector(pressText), for: .touchUpInside)
    }
    
    @objc private func pressText() {
        delegate?.pressTextStation(sender: self)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension TextStationView: MakeHideObject {
    func hide(_ hide: Bool) {
        if hide {
            button.setTitleColor(color.withAlphaComponent(0.3), for: .normal)
        }else{
            button.setTitleColor(color.withAlphaComponent(1), for: .normal)
        }
    }
}
