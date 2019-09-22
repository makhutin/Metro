//
//  FromToButtons.swift
//  Metro
//
//  Created by Mahutin Aleksei on 22/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

enum FromToButtonsStyle {
    case from, to
}

protocol FromToButtonsDelegate {
    func pressToButton(sender: UIView)
    func pressFromButton(sender: UIView)
}


@IBDesignable
class FromToButtons: UIView {
    
    
    let lightBlue = UIColor(displayP3Red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    var isSetup = false
    let from = UIButton(type: .system)
    let to = UIButton(type: .system)
    
    let height:CGFloat = 40
    let width:CGFloat = 120
    let space:CGFloat = 5
    var currentStyle:FromToButtonsStyle = .to
    
    var delegate:FromToButtonsDelegate?
    
    
    override func layoutSubviews() {
        self.frame.size = CGSize(width: width * 2 + 5, height: height)
        super.layoutSubviews()
        for elem in [from,to] {
            elem.layer.cornerRadius = height / 2
            elem.layer.borderWidth = 2
        }
        chageStyle()
        from.frame = CGRect(x: 10, y: 10, width: width, height: height)
        to.frame = CGRect(x: from.frame.origin.x + width + 5, y: from.frame.origin.y, width: width, height: height)
        from.setTitle("отсюда", for: .normal)
        to.setTitle("сюда", for: .normal)
        
        if isSetup { return }
        self.addSubview(to)
        self.addSubview(from)
        to.addTarget(self, action: #selector(pressToButton), for: .touchUpInside)
        to.addTarget(self, action: #selector(startToAnimate), for: [.touchDown,.touchDragInside])
        to.addTarget(self, action: #selector(endToAnimate), for: .touchDragOutside)
        from.addTarget(self, action: #selector(pressFromButton), for: .touchUpInside)
    }
    
    func chageStyle() {
        switch currentStyle {
        case .to:
            to.backgroundColor = lightBlue
            to.setTitleColor(.white, for: .normal)
            to.layer.borderColor = lightBlue.cgColor
            
            from.backgroundColor = .white
            from.setTitleColor(.lightGray, for: .normal)
            from.layer.borderColor = UIColor.lightGray.cgColor
        case .from:
            to.backgroundColor = .white
            to.setTitleColor(.lightGray, for: .normal)
            to.layer.borderColor = UIColor.lightGray.cgColor
            
            from.backgroundColor = lightBlue
            from.setTitleColor(.white, for: .normal)
            from.layer.borderColor = lightBlue.cgColor
        @unknown default:
            print("Oo")

        }
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//Animation and press events
extension FromToButtons {
    
    @objc func startToAnimate() {
        if currentStyle == .to {
            to.backgroundColor = .white
            to.setTitleColor(lightBlue, for: .normal)
        }
        
    }
    
    @objc func endToAnimate() {
        switch currentStyle {
        case .from:
            UIView.animate(withDuration: 0.4, animations: {
                self.to.layer.borderColor = UIColor.lightGray.cgColor
            }, completion: { complite in
                self.to.layer.borderColor = UIColor.lightGray.cgColor
            })
        case .to:
            
            UIView.animate(withDuration: 0.4, animations: {
                self.to.backgroundColor = self.lightBlue
                self.to.setTitleColor(.white, for: .normal)
            }, completion: { complite in
                self.to.backgroundColor = self.lightBlue
                self.to.setTitleColor(.white, for: .normal)
            })
        }
    }
    
    @objc func pressToButton() {
        endToAnimate()
        delegate?.pressToButton(sender: self)
    }
    
    @objc func startFromAnimate() {
        if currentStyle == .from {
            from.backgroundColor = .white
            from.setTitleColor(lightBlue, for: .normal)
        }
        
    }
    
    @objc func endFromAnimate() {
        switch currentStyle {
        case .to:
            UIView.animate(withDuration: 0.4, animations: {
                self.from.layer.borderColor = UIColor.lightGray.cgColor
            }, completion: { complite in
                self.from.layer.borderColor = UIColor.lightGray.cgColor
            })
        case .from:
            
            UIView.animate(withDuration: 0.4, animations: {
                self.from.backgroundColor = self.lightBlue
                self.from.setTitleColor(.white, for: .normal)
            }, completion: { complite in
                self.from.backgroundColor = self.lightBlue
                self.from.setTitleColor(.white, for: .normal)
            })
        }
    }
    
    @objc func pressFromButton() {
        endFromAnimate()
        delegate?.pressFromButton(sender: self)
    }

    
}
