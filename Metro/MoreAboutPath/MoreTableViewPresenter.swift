//
//  MoreTableViewPresenter.swift
//  Metro
//
//  Created by Алексей Махутин on 11.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

protocol MoreTableViewPresenterProtocol {
    
    var stationPath: [[StationInfo]] { get }
    
}

class MoreTableViewPresenter: MoreTableViewPresenterProtocol {
    
    weak var view: MoreTableView!
    
    private var data: [Int] = []
    
    init(viewcontroller: MoreTableView,data: [Int]) {
        view = viewcontroller
        self.data = data
        workWithData()
        finalWorkWithData()
    }
    
    let stationConfig = MetroConfig.share.allStations
    let linkConfig = MetroConfig.share.link
    let textConfig = MetroConfig.share.textStation
    var compliteData: [StationInfo] = []
    var stationPath: [[StationInfo]] = []
    
    private func finalWorkWithData() {
        stationPath = []
        var saveIndex = 1
        stationPath.append([])
        for i in 0..<compliteData.count {
                if compliteData[i].type == .transfer {
                    if stationPath.count - 1 != Int(saveIndex / 2) {
                        stationPath.append([])
                    }
                    stationPath[saveIndex / 2].append(compliteData[i])
                    saveIndex += 1
                    continue
            }
            if stationPath.count - 1 != Int(saveIndex / 2) {
                stationPath.append([])
            }
            stationPath[saveIndex / 2].append(compliteData[i])
        }
    }
    
    
    private func workWithData() {
        compliteData = []
        for i in 0..<data.count {
            
            var type: StationInfo.StationInfoConfig = .normal
            
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
    
    
}
