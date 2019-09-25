//
//  MultiStationView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 25/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit



enum StationCountForMulti {
    case two, three
}
@IBDesignable
class MultiStationView: UIView {
    
    var id:[Int] = []
    private var isSetup = false
    var stationCount: StationCountForMulti = .three
    var size:CGFloat = 20
    var centerY: CGFloat {
        return self.frame.height / 2
    }
    var centerX: CGFloat {
            return self.frame.width / 2
    }
    
    override func layoutSubviews() {
        
        
        super.layoutSubviews()
        
        if isSetup { return }
        
        self.backgroundColor = backgroundColor?.withAlphaComponent(0)
        switch stationCount {
        case .two:
            let view1Size = size + 4
            self.frame.size = CGSize(width: view1Size * 2, height: view1Size)
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 2
            self.backgroundColor = .white
            self.backgroundColor = .white
        case .three:
            self.backgroundColor = .white
            let view1Size = size + 4
            self.frame.size = CGSize(width: view1Size * 2, height: view1Size * 2)
            self.layer.cornerRadius = self.frame.height / 2
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 2
            self.backgroundColor = .white
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
