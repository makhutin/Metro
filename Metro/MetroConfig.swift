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


class MetroConfig {
    static let share = MetroConfig()
    
    let allStations = [
        MetroStation(coords: CGPoint(x: 18, y: 92), id: 1, color: .red),
        MetroStation(coords: CGPoint(x: 18.3, y: 88), id: 2, color: .red),
        MetroStation(coords: CGPoint(x: 18.7, y: 84), id: 3, color: .red),
        MetroStation(coords: CGPoint(x: 22, y: 80), id: 4, color: .red),
        MetroStation(coords: CGPoint(x: 27, y: 74.2), id: 5, color: .red),
        MetroStation(coords: CGPoint(x: 33, y: 70), id: 6, color: .red),
        MetroStation(coords: CGPoint(x: 39.5, y: 66), id: 7, color: .red),
        MetroStation(coords: CGPoint(x: 50.5, y: 58), id: 8, color: .red),
        MetroStation(coords: CGPoint(x: 56, y: 51), id: 9, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 44), id: 10, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 36), id: 11, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 32), id: 12, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 28), id: 13, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 24), id: 14, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 20), id: 15, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 16), id: 16, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 12), id: 17, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 8), id: 18, color: .red),
        MetroStation(coords: CGPoint(x: 59, y: 4.4), id: 19, color: .red),
        MetroStation(coords: CGPoint(x: 10, y: 30), id: 20, color: .red),
    ]
    
    let link = [
        1:[LinkWithTime(id: 2, time: 120)],
        2:[LinkWithTime(id: 1, time: 120),LinkWithTime(id: 3, time: 180)],
        3:[LinkWithTime(id: 2, time: 180),LinkWithTime(id: 4, time: 120)],
        4:[LinkWithTime(id: 3, time: 120),LinkWithTime(id: 5, time: 240)],
        5:[LinkWithTime(id: 4, time: 240),LinkWithTime(id: 6, time: 180)],
        6:[LinkWithTime(id: 5, time: 180),LinkWithTime(id: 7, time: 180)],
        7:[LinkWithTime(id: 6, time: 180),LinkWithTime(id: 8, time: 120)],
        8:[LinkWithTime(id: 7, time: 120),LinkWithTime(id: 9, time: 120)],
        9:[LinkWithTime(id: 8, time: 120),LinkWithTime(id: 10, time: 120)],
        10:[LinkWithTime(id: 9, time: 120),LinkWithTime(id: 11, time: 120)],
        11:[LinkWithTime(id: 10, time: 120),LinkWithTime(id: 12, time: 180)],
        12:[LinkWithTime(id: 11, time: 180),LinkWithTime(id: 13, time: 120)],
        13:[LinkWithTime(id: 12, time: 120),LinkWithTime(id: 14, time: 120)],
        14:[LinkWithTime(id: 13, time: 120),LinkWithTime(id: 15, time: 180)],
        15:[LinkWithTime(id: 14, time: 180),LinkWithTime(id: 16, time: 180)],
        16:[LinkWithTime(id: 15, time: 180),LinkWithTime(id: 17, time: 180)],
        17:[LinkWithTime(id: 16, time: 180),LinkWithTime(id: 18, time: 120)],
        18:[LinkWithTime(id: 17, time: 120),LinkWithTime(id: 19, time: 120)],
        19:[LinkWithTime(id: 18, time: 120)]
        ]
    
    let en = [1:"VETERANOV",2:"LENINSKIY"]
    
    func findEnd(start:Int, end:Int) -> [Int] {
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
                temp.map { if !queen.contains( $0.id ) && !visit.contains( $0.id ) { queen.append($0.id) } }
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
    
}
