//
//  MetroConfig.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation
import UIKit

struct MetroStation {
    let coords: CGPoint
    let id: Int
    let color: UIColor
}

struct LinkWithTime {
    let id: Int
    let time: Int
}

struct LineBetweenStations {
    let fromId: Int
    let toId: Int
}

struct CoordsBetweenStationsWithColor {
    let fromCoords: CGPoint
    let toCoords: CGPoint
    let color: UIColor
}


class MetroConfig {
    static let share = MetroConfig()
    
    
    let allStations = [
        MetroStation(coords: CGPoint(x: 20, y: 95), id: 1, color: .red),
        MetroStation(coords: CGPoint(x: 20, y: 90), id: 2, color: .red),
        MetroStation(coords: CGPoint(x: 20, y: 85), id: 3, color: .red),
        MetroStation(coords: CGPoint(x: 20, y: 80), id: 4, color: .red),
        MetroStation(coords: CGPoint(x: 27, y: 74.5), id: 5, color: .red),
        MetroStation(coords: CGPoint(x: 33, y: 70.5), id: 6, color: .red),
        MetroStation(coords: CGPoint(x: 39.5, y: 66), id: 7, color: .red),
        MetroStation(coords: CGPoint(x: 50.5, y: 58), id: 8, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 51), id: 9, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 43), id: 10, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 36), id: 11, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 32), id: 12, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 28), id: 13, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 24), id: 14, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 20), id: 15, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 16), id: 16, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 12), id: 17, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 8), id: 18, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 4.4), id: 19, color: .red),
        MetroStation(coords: CGPoint(x: 42, y: 96), id: 20, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 92), id: 21, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 87.5), id: 22, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 83.5), id: 23, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 79), id: 24, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 75.5), id: 25, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 70.5), id: 26, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 64.5), id: 27, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 49.6), id: 28, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 43), id: 29, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 34), id: 30, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 30), id: 31, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 26), id: 32, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 22), id: 33, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 18), id: 34, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 14), id: 35, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 10), id: 36, color: .blue),
        MetroStation(coords: CGPoint(x: 42, y: 4.4), id: 37, color: .blue),
        MetroStation(coords: CGPoint(x: 76, y: 95), id: 38, color: .green),
        MetroStation(coords: CGPoint(x: 76, y: 88), id: 39, color: .green),
        MetroStation(coords: CGPoint(x: 76, y: 81), id: 40, color: .green),
        MetroStation(coords: CGPoint(x: 76, y: 74), id: 41, color: .green),
        MetroStation(coords: CGPoint(x: 76, y: 67), id: 42, color: .green),
        MetroStation(coords: CGPoint(x: 76, y: 51), id: 43, color: .green),
        MetroStation(coords: CGPoint(x: 59, y: 40.5), id: 44, color: .green),
        MetroStation(coords: CGPoint(x: 42, y: 40.5), id: 45, color: .green),
        MetroStation(coords: CGPoint(x: 17, y: 40.5), id: 46, color: .green),
        MetroStation(coords: CGPoint(x: 10, y: 34), id: 47, color: .green),
        MetroStation(coords: CGPoint(x: 10, y: 27), id: 48, color: .green),
        MetroStation(coords: CGPoint(x: 10, y: 20), id: 49, color: .green),
        MetroStation(coords: CGPoint(x: 93, y: 80), id: 50, color: .yellow),
        MetroStation(coords: CGPoint(x: 93, y: 75), id: 51, color: .yellow),
        MetroStation(coords: CGPoint(x: 93, y: 65), id: 52, color: .yellow),
        MetroStation(coords: CGPoint(x: 93, y: 60), id: 53, color: .yellow),
        MetroStation(coords: CGPoint(x: 76, y: 48.5), id: 54, color: .yellow),
        MetroStation(coords: CGPoint(x: 67.5, y: 48.5), id: 55, color: .yellow),
        MetroStation(coords: CGPoint(x: 59, y: 48.5), id: 56, color: .yellow),
        MetroStation(coords: CGPoint(x: 44.5, y: 48.5), id: 57, color: .yellow),
        MetroStation(coords: CGPoint(x: 59, y: 85), id: 58, color: .purple),
        MetroStation(coords: CGPoint(x: 59, y: 78), id: 59, color: .purple),
        MetroStation(coords: CGPoint(x: 59, y: 72), id: 60, color: .purple),
        MetroStation(coords: CGPoint(x: 59, y: 60), id: 61, color: .purple),
        MetroStation(coords: CGPoint(x: 53, y: 56), id: 62, color: .purple),
        MetroStation(coords: CGPoint(x: 42, y: 47.5), id: 63, color: .purple),
        MetroStation(coords: CGPoint(x: 34, y: 44), id: 64, color: .purple),
        MetroStation(coords: CGPoint(x: 25, y: 34), id: 65, color: .purple),
        MetroStation(coords: CGPoint(x: 25, y: 28.5), id: 66, color: .purple),
        MetroStation(coords: CGPoint(x: 25, y: 23), id: 67, color: .purple),
        MetroStation(coords: CGPoint(x: 25, y: 16.5), id: 68, color: .purple),
        MetroStation(coords: CGPoint(x: 25, y: 10), id: 69, color: .purple),
        MetroStation(coords: CGPoint(x: 20, y: 36), id: 70, color: .purple),]
    
    let link = [
        1:[LinkWithTime(id: 2, time: 120)],
        2:[LinkWithTime(id: 1, time: 120),LinkWithTime(id: 3, time: 180)],
        3:[LinkWithTime(id: 2, time: 180),LinkWithTime(id: 4, time: 120)],
        4:[LinkWithTime(id: 3, time: 120),LinkWithTime(id: 5, time: 240)],
        5:[LinkWithTime(id: 4, time: 240),LinkWithTime(id: 6, time: 180)],
        6:[LinkWithTime(id: 5, time: 180),LinkWithTime(id: 7, time: 180)],
        7:[LinkWithTime(id: 6, time: 180),LinkWithTime(id: 8, time: 120),LinkWithTime(id: 27, time: 120)],
        8:[LinkWithTime(id: 7, time: 120),LinkWithTime(id: 9, time: 120),LinkWithTime(id: 62, time: 180)],
        9:[LinkWithTime(id: 8, time: 120),LinkWithTime(id: 10, time: 120),LinkWithTime(id: 56, time: 180)],
        10:[LinkWithTime(id: 9, time: 120),LinkWithTime(id: 11, time: 120),LinkWithTime(id: 44, time: 180)],
        11:[LinkWithTime(id: 10, time: 120),LinkWithTime(id: 12, time: 180)],
        12:[LinkWithTime(id: 11, time: 180),LinkWithTime(id: 13, time: 120)],
        13:[LinkWithTime(id: 12, time: 120),LinkWithTime(id: 14, time: 120)],
        14:[LinkWithTime(id: 13, time: 120),LinkWithTime(id: 15, time: 180)],
        15:[LinkWithTime(id: 14, time: 180),LinkWithTime(id: 16, time: 180)],
        16:[LinkWithTime(id: 15, time: 180),LinkWithTime(id: 17, time: 180)],
        17:[LinkWithTime(id: 16, time: 180),LinkWithTime(id: 18, time: 120)],
        18:[LinkWithTime(id: 17, time: 120),LinkWithTime(id: 19, time: 120)],
        19:[LinkWithTime(id: 18, time: 120)],
        20:[LinkWithTime(id: 21, time: 180)],
        21:[LinkWithTime(id: 20, time: 180),LinkWithTime(id: 22, time: 240)],
        22:[LinkWithTime(id: 21, time: 240),LinkWithTime(id: 23, time: 180)],
        23:[LinkWithTime(id: 22, time: 180),LinkWithTime(id: 24, time: 120)],
        24:[LinkWithTime(id: 23, time: 120),LinkWithTime(id: 25, time: 120)],
        25:[LinkWithTime(id: 24, time: 120),LinkWithTime(id: 26, time: 120)],
        26:[LinkWithTime(id: 25, time: 120),LinkWithTime(id: 27, time: 120)],
        27:[LinkWithTime(id: 26, time: 120),LinkWithTime(id: 28, time: 180),LinkWithTime(id: 7, time: 120)],
        28:[LinkWithTime(id: 27, time: 180),LinkWithTime(id: 29, time: 120),LinkWithTime(id: 63, time: 180),LinkWithTime(id: 57, time: 180)],
        29:[LinkWithTime(id: 28, time: 120),LinkWithTime(id: 30, time: 240),LinkWithTime(id: 45, time: 180)],
        30:[LinkWithTime(id: 29, time: 240),LinkWithTime(id: 31, time: 120)],
        31:[LinkWithTime(id: 30, time: 120),LinkWithTime(id: 32, time: 240)],
        32:[LinkWithTime(id: 31, time: 240),LinkWithTime(id: 33, time: 180)],
        33:[LinkWithTime(id: 32, time: 180),LinkWithTime(id: 34, time: 180)],
        34:[LinkWithTime(id: 33, time: 180),LinkWithTime(id: 35, time: 180)],
        35:[LinkWithTime(id: 34, time: 180),LinkWithTime(id: 36, time: 120)],
        36:[LinkWithTime(id: 35, time: 120),LinkWithTime(id: 37, time: 180)],
        37:[LinkWithTime(id: 36, time: 180)],
        38:[LinkWithTime(id: 39, time: 240)],
        39:[LinkWithTime(id: 38, time: 240),LinkWithTime(id: 40, time: 180)],
        40:[LinkWithTime(id: 39, time: 180),LinkWithTime(id: 41, time: 180)],
        41:[LinkWithTime(id: 40, time: 180),LinkWithTime(id: 42, time: 180)],
        42:[LinkWithTime(id: 41, time: 180),LinkWithTime(id: 43, time: 300)],
        43:[LinkWithTime(id: 42, time: 300),LinkWithTime(id: 44, time: 180),LinkWithTime(id: 54, time: 180)],
        44:[LinkWithTime(id: 43, time: 180),LinkWithTime(id: 45, time: 180),LinkWithTime(id: 10, time: 180)],
        45:[LinkWithTime(id: 44, time: 180),LinkWithTime(id: 46, time: 240),LinkWithTime(id: 29, time: 180)],
        46:[LinkWithTime(id: 45, time: 240),LinkWithTime(id: 47, time: 240)],
        47:[LinkWithTime(id: 46, time: 240),LinkWithTime(id: 48, time: 240)],
        48:[LinkWithTime(id: 47, time: 240),LinkWithTime(id: 49, time: 240)],
        49:[LinkWithTime(id: 48, time: 240)],
        50:[LinkWithTime(id: 51, time: 180)],
        51:[LinkWithTime(id: 50, time: 180),LinkWithTime(id: 52, time: 180)],
        52:[LinkWithTime(id: 51, time: 180),LinkWithTime(id: 53, time: 180)],
        53:[LinkWithTime(id: 52, time: 180),LinkWithTime(id: 54, time: 180)],
        54:[LinkWithTime(id: 53, time: 180),LinkWithTime(id: 55, time: 120),LinkWithTime(id: 43, time: 180)],
        55:[LinkWithTime(id: 54, time: 120),LinkWithTime(id: 56, time: 120)],
        56:[LinkWithTime(id: 55, time: 120),LinkWithTime(id: 57, time: 240),LinkWithTime(id: 9, time: 180)],
        57:[LinkWithTime(id: 56, time: 240),LinkWithTime(id: 28, time: 180),LinkWithTime(id: 63, time: 180)],
        58:[LinkWithTime(id: 59, time: 180)],
        59:[LinkWithTime(id: 58, time: 180),LinkWithTime(id: 60, time: 180)],
        60:[LinkWithTime(id: 59, time: 180),LinkWithTime(id: 61, time: 180)],
        61:[LinkWithTime(id: 60, time: 180),LinkWithTime(id: 62, time: 180)],
        62:[LinkWithTime(id: 61, time: 180),LinkWithTime(id: 63, time: 240),LinkWithTime(id: 8, time: 180)],
        63:[LinkWithTime(id: 62, time: 240),LinkWithTime(id: 64, time: 180),LinkWithTime(id: 28, time: 180),LinkWithTime(id: 57, time: 180)],
        64:[LinkWithTime(id: 63, time: 180),LinkWithTime(id: 65, time: 180)],
        65:[LinkWithTime(id: 64, time: 180),LinkWithTime(id: 66, time: 120)],
        66:[LinkWithTime(id: 65, time: 120),LinkWithTime(id: 67, time: 240)],
        67:[LinkWithTime(id: 66, time: 240),LinkWithTime(id: 68, time: 180)],
        68:[LinkWithTime(id: 67, time: 180),LinkWithTime(id: 69, time: 180)],
        69:[LinkWithTime(id: 68, time: 180)]
    ]
    
    let lines = [0:[LineBetweenStations(fromId: 1, toId: 2),
                     LineBetweenStations(fromId: 2, toId: 3),
                     LineBetweenStations(fromId: 3, toId: 4),
                     LineBetweenStations(fromId: 4, toId: 5),
                     LineBetweenStations(fromId: 5, toId: 6),
                     LineBetweenStations(fromId: 6, toId: 7),
                     LineBetweenStations(fromId: 7, toId: 8),
                     LineBetweenStations(fromId: 8, toId: 9),
                     LineBetweenStations(fromId: 9, toId: 10),
                     LineBetweenStations(fromId: 10, toId: 11),
                     LineBetweenStations(fromId: 11, toId: 12),
                     LineBetweenStations(fromId: 12, toId: 13),
                     LineBetweenStations(fromId: 13, toId: 14),
                     LineBetweenStations(fromId: 14, toId: 15),
                     LineBetweenStations(fromId: 15, toId: 16),
                     LineBetweenStations(fromId: 16, toId: 17),
                     LineBetweenStations(fromId: 17, toId: 18),
                     LineBetweenStations(fromId: 18, toId: 19)],
                  1:[LineBetweenStations(fromId: 20, toId: 21),
                     LineBetweenStations(fromId: 21, toId: 22),
                     LineBetweenStations(fromId: 22, toId: 23),
                     LineBetweenStations(fromId: 23, toId: 24),
                     LineBetweenStations(fromId: 24, toId: 25),
                     LineBetweenStations(fromId: 25, toId: 26),
                     LineBetweenStations(fromId: 26, toId: 27),
                     LineBetweenStations(fromId: 27, toId: 28),
                     LineBetweenStations(fromId: 28, toId: 29),
                     LineBetweenStations(fromId: 29, toId: 30),
                     LineBetweenStations(fromId: 30, toId: 31),
                     LineBetweenStations(fromId: 31, toId: 32),
                     LineBetweenStations(fromId: 32, toId: 33),
                     LineBetweenStations(fromId: 33, toId: 34),
                     LineBetweenStations(fromId: 34, toId: 35),
                     LineBetweenStations(fromId: 35, toId: 36),
                     LineBetweenStations(fromId: 36, toId: 37),],
                  2:[LineBetweenStations(fromId: 38, toId: 39),
                     LineBetweenStations(fromId: 39, toId: 40),
                     LineBetweenStations(fromId: 40, toId: 41),
                     LineBetweenStations(fromId: 41, toId: 42),
                     LineBetweenStations(fromId: 42, toId: 43),
                     LineBetweenStations(fromId: 43, toId: 44),
                     LineBetweenStations(fromId: 44, toId: 45),
                     LineBetweenStations(fromId: 45, toId: 46),
                     LineBetweenStations(fromId: 46, toId: 47),
                     LineBetweenStations(fromId: 47, toId: 48),
                     LineBetweenStations(fromId: 48, toId: 49)],
                  3:[LineBetweenStations(fromId: 50, toId: 51),
                     LineBetweenStations(fromId: 51, toId: 52),
                     LineBetweenStations(fromId: 52, toId: 53),
                     LineBetweenStations(fromId: 53, toId: 54),
                     LineBetweenStations(fromId: 54, toId: 55),
                     LineBetweenStations(fromId: 55, toId: 56),
                     LineBetweenStations(fromId: 56, toId: 57)],
                  4:[LineBetweenStations(fromId: 58, toId: 59),
                     LineBetweenStations(fromId: 59, toId: 60),
                     LineBetweenStations(fromId: 60, toId: 61),
                     LineBetweenStations(fromId: 61, toId: 62),
                     LineBetweenStations(fromId: 62, toId: 63),
                     LineBetweenStations(fromId: 63, toId: 64),
                     LineBetweenStations(fromId: 64, toId: 65),
                     LineBetweenStations(fromId: 65, toId: 66),
                     LineBetweenStations(fromId: 66, toId: 67),
                     LineBetweenStations(fromId: 67, toId: 68),
                     LineBetweenStations(fromId: 68, toId: 69),
                     LineBetweenStations(fromId: 65, toId: 70)]
    ]
    
    
    let multistation = [7,8,9,10,27,28,29,43,44,45,54,55,56,57]
    
    let en = [1:"VETERANOV",2:"LENINSKIY"]
    
    func finder(start:Int, end:Int, way:Int) -> [Int] {
        if !link.keys.contains(start){ return [] }
        if !link.keys.contains(end){ return [] }
        var target = start
        var queen = [target]
        var visit = [Int]()
        var find = false
        while !find {
            if queen.first != nil {
                target = queen.remove(at: 0)
                visit.append(target)
            }else{
                break
            }
            if target == end {
                find = true
            }else{
                let temp = link[target] ?? []
                switch way {
                case 0:
                    for elem in temp.reversed() {
                        if !queen.contains( elem.id ) && !visit.contains( elem.id ){
                            queen.append(elem.id)
                        }
                    }
                case 1:
                    for elem in temp.shuffled() {
                        if !queen.contains( elem.id ) && !visit.contains( elem.id ){
                            queen.append(elem.id)
                        }
                    }
                case 2:
                    for elem in temp.reversed().shuffled() {
                        if !queen.contains( elem.id ) && !visit.contains( elem.id ){
                            queen.append(elem.id)
                        }
                    }
                    
                case 3:
                    for elem in temp {
                        if !queen.contains( elem.id ) && !visit.contains( elem.id ){
                            queen.append(elem.id)
                        }
                    }
                default:
                    return [0,1]
                }

                
            }
        }
        visit = visit.reversed()
        var path = [visit.first!]
        var next:Int = 0
        var startPath = visit.remove(at: 0)
        while find {
            if visit.first != nil {
                next = visit.first!
                let temp = link[startPath] ?? []
                let tempId = temp.map { $0.id }
                if tempId.contains( next ) {
                    path.append(next)
                    startPath = visit.remove(at: 0)
                }else{
                    visit.remove(at: 0)
                }
            }else{
                find = false
            }
        }
        
        
        return path.reversed()
    }
    
    func findEnd(start:Int, end:Int) -> [Int] {
        let way1 = finder(start: start, end: end, way: 0)
        let way2 = finder(start: start, end: end, way: 1)
        let way3 = finder(start: start, end: end, way: 2)
        let way4 = finder(start: start, end: end, way: 3)
        var time1 = 0
        var time2 = 0
        var time3 = 0
        var time4 = 0
        
        for index in 0..<way1.count - 1 {
            for elem in link[way1[index]]! {
                if elem.id == way1[index + 1] {
                    time1 += elem.time
                }
            }
        }
        for index in 0..<way2.count - 1 {
            for elem in link[way2[index]]! {
                if elem.id == way2[index + 1] {
                    time2 += elem.time
                }
            }
        }
        for index in 0..<way3.count - 1 {
            for elem in link[way3[index]]! {
                if elem.id == way3[index + 1] {
                    time3 += elem.time
                }
            }
        }
        for index in 0..<way4.count - 1 {
            for elem in link[way4[index]]! {
                if elem.id == way4[index + 1] {
                    time4 += elem.time
                }
            }
        }
        print(time1)
        print(way1)
        print(time2)
        print(way2)
        print(time3)
        print(way3)
        print(time4)
        print(way4)
        switch min(time1,time2,time3,time4) {
        case time1:
            return way1
        case time2:
            return way2
        case time3:
            return way3
        case time4:
            return way4
        default:
            return way1
        }
    }
}
