//
//  MetroStation.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol MetroDonatOneDelegate {
    func tapOnDonat(sender:Any)
}

@IBDesignable
class MetroDonatOne: UIView {
    
    private var isSetup = false
    
    var id: Int = 0
    var scaled = false
    var donatColor:UIColor = .red
    private let stroke:CGFloat = 10
    private let donat = UIView()
    var delegate:MetroDonatOneDelegate?
    var centerX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.width / 2
        }
    }
    var centerY: CGFloat {
        get {
            return self.frame.origin.y + self.frame.height / 2
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.width / 2
        
        donat.frame = CGRect(x: stroke / 2, y: stroke / 2, width: self.frame.width - stroke , height: self.frame.height - stroke)
        donat.layer.cornerRadius = donat.frame.width / 2
        donat.backgroundColor = donatColor
        
        if isSetup { return }
        let TapGeasture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(TapGeasture)
        self.addSubview(donat)
    }
    
    @objc private func handleTap() {
        delegate?.tapOnDonat(sender: self)
    }
    
    
    private func updateColor() {
        donat.backgroundColor = donatColor
        donat.layoutIfNeeded()
    }
}

extension MetroDonatOne: ScalledObjectView {
    
    func scale() {
        if self.scaled{
            let scaleValue:CGFloat = 5
            UIView.animate(withDuration: 0.6, animations: {
                self.frame.origin = CGPoint(x: self.frame.origin.x - scaleValue / 2,
                                            y: self.frame.origin.y - scaleValue / 2)
                self.frame.size = CGSize(width: self.frame.size.width + scaleValue,
                                         height: self.frame.size.height + scaleValue)
                self.layoutIfNeeded()
            })
            self.scaled = false
        }
    }
    
    func unScale() {
        if !self.scaled {
            let scaleValue:CGFloat = 5
            UIView.animate(withDuration: 0.6, animations: {
                self.frame.origin = CGPoint(x: self.frame.origin.x + scaleValue / 2,
                                            y: self.frame.origin.y + scaleValue / 2)
                self.frame.size = CGSize(width: self.frame.size.width - scaleValue,
                                         height: self.frame.size.height - scaleValue)
                self.layoutIfNeeded()
            })
            self.scaled = true
        }
        
    }

}

extension MetroDonatOne: MakeHideObject {
    
    func hide(_ hide: Bool) {
        if hide {
            UIView.animate(withDuration: 0.6, animations: {
                self.donatColor = self.donatColor.withAlphaComponent(0.3)
                self.updateColor()
            })
        }else{
            UIView.animate(withDuration: 0.6, animations: {
                self.donatColor = self.donatColor.withAlphaComponent(1)
                self.updateColor()
            })
        }
    }
    
}
