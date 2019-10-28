//
//  MoreTableView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 26/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

enum StationInfoConfig {
    case start, end, normal, transfer, donat
}

struct StationInfo {
    let name: String
    let time: Date
    let type: StationInfoConfig
    let color: UIColor
}

class MoreTableView: UITableViewController {
    
    var data: [Int] = []
    let stationConfig = MetroConfig.share.allStations
    let linkConfig = MetroConfig.share.link
    let textConfig = MetroConfig.share.textStation
    var compliteData: [StationInfo] = []
    var finalData: [[StationInfo]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        workWithData()
        finalWorkWithData()
        for elem in finalData {
            print("cool")
            for pr in elem {
                print(pr.name)
                print(pr.type)
            }
        }
        self.tableView.rowHeight = 40
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    private func finalWorkWithData() {
        finalData = []
        var saveIndex = 1
        finalData.append([])
        for i in 0..<compliteData.count {
                if compliteData[i].type == .transfer {
                    if finalData.count - 1 != Int(saveIndex / 2) {
                        finalData.append([])
                    }
                    finalData[saveIndex / 2].append(compliteData[i])
                    saveIndex += 1
                    continue
            }
            if finalData.count - 1 != Int(saveIndex / 2) {
                finalData.append([])
            }
            finalData[saveIndex / 2].append(compliteData[i])
        }
    }
    
    
    private func workWithData() {
        compliteData = []
        for i in 0..<data.count {
            
            var type: StationInfoConfig = .normal
            
            if i == 0 {
                type = .start
            } else if i == data.count - 1 {
                type = .end
            }
            
            if stationConfig[data[i]]?.multi ?? false {
                if i == 0 {
                     if stationConfig[data[i]]?.color != stationConfig[data[i+1]]?.color {
                        type = .transfer
                    }
                }else if i == data.count - 1 {
                    if stationConfig[data[i]]?.color != stationConfig[data[i-1]]?.color {
                        type = .transfer
                    }
                }else {
                    if stationConfig[data[i + 1]]?.multi ?? false || stationConfig[data[i - 1]]?.multi ?? false {
                        if stationConfig[data[i]]?.color != stationConfig[data[i+1]]?.color || stationConfig[data[i]]?.color != stationConfig[data[i-1]]?.color {
                            type = .transfer
                        }
                    }
                }
            }
            
            let text = textConfig["ru_RU"]?[data[i]] ?? "error"
            
            var time: Date
            
            if i == 0 {
                time = Date()
            }else{
                time = compliteData[i - 1].time
                let calendar = Calendar.current
                var timeWay = 0
                for elem in linkConfig[data[i]]! {
                    if elem.id == data[i - 1] {
                        timeWay = elem.time
                    }
                }
                time = calendar.date(byAdding: .second, value: timeWay, to: time)!
            }
            
            let color = stationConfig[data[i]]!.color
            
            compliteData.append(StationInfo(name: text, time: time, type: type, color: color))
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return finalData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return finalData[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1.0 : 80
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StationInfoCell()
        let data = finalData[indexPath.section]
        var type = data[indexPath.row].type
        if type == .transfer {
            if indexPath.row == 0 {
                type = .start
            }
            else {
                type = .end
            }
        }
//        cell.name.text = data[indexPath.row].name
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: data[indexPath.row].time)
        let minute = calendar.component(.minute, from: data[indexPath.row].time)
        
        cell.setName(name: data[indexPath.row].name)
        cell.setTime(time: "\(hour < 10 ? "0" + String(hour) : String(hour)):\(minute < 10 ? "0" + String(minute) : String(minute))")
        
        cell.type = type
        
        if indexPath.section == 0 && indexPath.row == 0 && data.count == 1 {
            type = .donat
        }else if indexPath.section == finalData.count - 1 && indexPath.row == data.count - 1 && data.count == 1 {
            type = .donat
        }
        
        cell.line.setLine(color: data[indexPath.row].color, type: type)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let cell = TransferCell()
            cell.setName(name: "Сделайте пересадку")
            
            let data = finalData[section]
            let data2 = finalData[section - 1]
            let timeEnd = data.first!.time.timeIntervalSince1970
            let timeStart = data2.last!.time.timeIntervalSince1970
            let finalTime = Int((timeEnd - timeStart) / 60)
            
            cell.setTime(time: "\(finalTime) мин")
            
                return cell
                
        }else{
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == finalData.count - 1 && !finalData.isEmpty{
            let cell = TransferCell()
            cell.setName(name: "Общие время в пути составит")
            let timeEnd = finalData.last!.last!.time.timeIntervalSince1970
            let timeStart = finalData.first!.first!.time.timeIntervalSince1970
            let finalTime = Int((timeEnd - timeStart) / 60)
            cell.imgView.isHidden = true
            cell.setTime(time: "\(finalTime) мин")
                return cell
        }else{
            return UIView()
        }
    }


}
