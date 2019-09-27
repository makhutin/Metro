//
//  TransferCell.swift
//  Metro
//
//  Created by Mahutin Aleksei on 27/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

class TransferCell: UITableViewCell {
    
    let name = UILabel()
    let time = UILabel()
    let imgView = UIImageView()
    var isSetup = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didMoveToSuperview() {
        time.font = UIFont(name: "Helvetica", size: 10)
        time.sizeToFit()
        time.frame.origin = CGPoint(x:self.frame.width / 2 - name.frame.width / 2 + name.frame.height + 3,
                                    y: self.frame.height / 4 - time.frame.height / 2 + self.frame.height / 2)
        
        name.font = UIFont(name: "Helvetica", size: 10)
        name.sizeToFit()
        name.frame.origin = CGPoint(x: self.frame.width / 2 - name.frame.width / 2,
                            y: self.frame.height / 4 - name.frame.height / 2)
        
        imgView.image = UIImage(named: "run")
        imgView.frame = CGRect(x: self.frame.width / 2 - name.frame.width / 2,
                               y: self.frame.height / 4 - time.frame.height / 2 + self.frame.height / 2,
                               width: name.frame.height,
                               height: name.frame.height)
        
        self.addSubview(time)
        self.addSubview(name)
        self.addSubview(imgView)
        
        isSetup = true
    }

    
    func setName(name: String) {
        self.name.font = UIFont(name: "Helvetica", size: 10)
        self.name.text = name
        self.name.sizeToFit()
        self.name.frame.origin = CGPoint(x: self.time.frame.origin.x + self.frame.width / 10 + 40,
                                    y: self.frame.height / 2 - self.name.frame.height / 2)
        layoutIfNeeded()
    }
    
    func setTime(time: String) {
        self.time.font = UIFont(name: "Helvetica", size: 10)
        self.time.text = time
        self.time.sizeToFit()
        self.time.frame.origin = CGPoint(x:self.frame.width / 10, y: self.frame.height / 2 - self.time.frame.height / 2)
        layoutIfNeeded()
    }


}
