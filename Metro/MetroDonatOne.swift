//
//  MetroStation.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol DonatDelegate {
    func tap(tape:Any)
}

@IBDesignable
class MetroDonatOne: UIView,DonatDelegate {
    
    var isSetup = false
    
    var donatColor:UIColor = .red
    let stroke:CGFloat = 10
    let donat = UIView()
    let text = UILabel()
    
    
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
    
    @objc func handleTap() {
        tap(tape: self)
    }
    
    func tap(tape: Any) {
    }
    
}
