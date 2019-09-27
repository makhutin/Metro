//
//  MoreTableView.swift
//  Metro
//
//  Created by Mahutin Aleksei on 26/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

enum StationInfoConfig {
    case start, end, normal, transfer
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
        self.tableView.dataSource = self
        self.tableView.reloadData()
        var index = 0
        for elem in finalData {
            index += 1
            for station in elem {
                print(station.name)
                print(index)
            }
        }
        for elem in compliteData {
            let calendar = Calendar.current
            print("\(calendar.component(.hour, from: elem.time)) : \(calendar.component(.minute, from: elem.time))")
            switch elem.type {
            case .start:
                print("start")
            case .normal:
                print("normal")
            case .transfer:
                print("transfer")
            case .end:
                print("end")
            }

            print("\(elem.name)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    private func finalWorkWithData() {
        var saveIndex = 1
        finalData.append([])
        for i in 0..<compliteData.count {
            if i > 0 && i != compliteData.count - 1 {
                if compliteData[i].type == .transfer {
                    if finalData.count != saveIndex / 2 {
                        finalData.append([])
                    }
                    finalData[saveIndex / 2].append(compliteData[i])
                    saveIndex += 1
                    continue
                }
            }
            if finalData.count != saveIndex / 2 {
                finalData.append([])
            }
            finalData[saveIndex / 2].append(compliteData[i])
        }
    }
    
    
    private func workWithData() {
        for i in 0..<data.count {
            
            var type: StationInfoConfig = .normal
            
            if i == 0 {
                type = .start
            } else if i == data.count - 1 {
                type = .end
            }
            
            if stationConfig[data[i]]?.multi ?? false && i != data.count - 1 {
                if stationConfig[data[i + 1]]?.multi ?? false || stationConfig[data[i - 1]]?.multi ?? false {
                    if stationConfig[data[i]]?.color != stationConfig[data[i+1]]?.color || stationConfig[data[i]]?.color != stationConfig[data[i-1]]?.color {
                        type = .transfer
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StationInfoCell()
        let data = finalData[indexPath.section]
//        cell.name.text = data[indexPath.row].name
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: data[indexPath.row].time)
        let minute = calendar.component(.minute, from: data[indexPath.row].time)
        cell.setName(name: data[indexPath.row].name)
        cell.setTime(time: "\(hour < 10 ? "0" + String(hour) : String(hour)):\(minute < 10 ? "0" + String(minute) : String(minute))")

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
