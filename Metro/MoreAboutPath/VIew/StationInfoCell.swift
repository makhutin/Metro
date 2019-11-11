//
//  StationInfoCell.swift
//  Metro
//
//  Created by Mahutin Aleksei on 26/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

class StationInfoCell: UITableViewCell {
    
    let name = UILabel()
    let time = UILabel()
    let line = ForAboutPathView()
    var isSetup = false
    var type: StationInfo.StationInfoConfig = .normal
    
    override func didMoveToSuperview() {
        
        switch type {
        case .end,.start,.transfer:
            name.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        default:
            name.font = UIFont(name: "Helvetica", size: 10)
        }
        
        line.frame = CGRect(x: 90 , y: 0, width: 10, height: self.frame.height)
        
        time.font = UIFont(name: "Helvetica", size: 10)
        time.sizeToFit()
        time.textAlignment = .right
        time.frame.origin = CGPoint(x:line.frame.origin.x - 10 - time.frame.width,
                                    y: self.frame.height / 2 - time.frame.height / 2)
        
        name.sizeToFit()
        name.frame.origin = CGPoint(x: line.frame.width + line.frame.origin.x + 10,
                                    y: self.frame.height / 2 - name.frame.height / 2)
        
        for elem in [time,name,line] {
            self.addSubview(elem)
        }
        isSetup = true
    }
    
    func setup(data:[[StationInfo]], indexPath: IndexPath) {
        let newdata = data[indexPath.section]
        var type = newdata[indexPath.row].type
        if type == .transfer {
            if indexPath.row == 0 {
                type = .start
            }
            else {
                type = .end
            }
        }
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: newdata[indexPath.row].time)
        let minute = calendar.component(.minute, from: newdata[indexPath.row].time)
        
        setName(name: newdata[indexPath.row].name)
        setTime(time: "\(hour < 10 ? "0" + String(hour) : String(hour)):\(minute < 10 ? "0" + String(minute) : String(minute))")
        
        self.type = type
        
        if indexPath.section == 0 && indexPath.row == 0 && newdata.count == 1 {
            type = .donat
        }else if indexPath.section == data.count - 1 && indexPath.row == newdata.count - 1 && newdata.count == 1 {
            type = .donat
        }
        line.setLine(color: newdata[indexPath.row].color, type: type)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {

        // Configure the view for the selected state
    }
    
    private func setName(name: String) {
        self.name.font = UIFont(name: "Helvetica", size: 10)
        self.name.text = name
        self.name.sizeToFit()
        self.name.frame.origin = CGPoint(x: self.time.frame.origin.x + self.frame.width / 10 + 40,
                                         y: self.frame.height / 2 - self.name.frame.height / 2)
        layoutIfNeeded()
    }
    
    private func setTime(time: String) {
        self.time.font = UIFont(name: "Helvetica", size: 10)
        self.time.text = time
        self.time.sizeToFit()
        self.time.frame.origin = CGPoint(x:self.frame.width / 10,
                                         y: self.frame.height / 2 - self.time.frame.height / 2)
        layoutIfNeeded()
    }
    

}
