//
//  RouteBuilder.swift
//  Metro
//
//  Created by Алексей Махутин on 24.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation


class RouteBuilder {
    
    static let share = RouteBuilder()
    private init() {}
    
    private let link = MetroConfig.share.link
    
    private func finder(start:Int, end:Int, way:Int) -> [Int] {
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
    
    func buildPath(start:Int, end:Int) -> [Int] {
        let old = Date()
        let queue = DispatchQueue(label: "wayDispatch",qos: .userInteractive, attributes: .concurrent)
        var way1: [Int] = []
        var way2: [Int] = []
        var way3: [Int] = []
        var time1 = 0
        var time2 = 0
        var time3 = 0
        queue.async{ [unowned self] in
            way1 = self.finder(start: start, end: end, way: 0)
            for index in 0..<way1.count - 1 {
                print("1")
                for elem in self.link[way1[index]]! {
                    if elem.id == way1[index + 1] {
                        time1 += elem.time
                    }
                }
            }
        }
        
        queue.async{ [unowned self] in
            way2 = self.finder(start: start, end: end, way: 1)
            for index in 0..<way2.count - 1 {
                print("2")
                for elem in self.link[way2[index]]! {
                    if elem.id == way2[index + 1] {
                        time2 += elem.time
                    }
                }
            }
        }
        
        queue.async{ [unowned self] in
            way3 = self.finder(start: start, end: end, way: 2)
            for index in 0..<way3.count - 1 {
                print("3")
                for elem in self.link[way3[index]]! {
                    if elem.id == way3[index + 1] {
                        time3 += elem.time
                    }
                }
            }
        }
        
        var result: [Int] = []
        
        
        
        queue.sync(flags: .barrier, execute: {
            NSLog("time for path -- way1 - \(time1),way2 - \(time2),way3 - \(time3)")
            switch min(time1,time2,time3) {
            case time1:
                result = way1
                NSLog("select -- way1")
            case time2:
                result = way2
                NSLog("select -- way2")
            case time3:
                result = way3
                NSLog("select -- way3")
            default:
                result = way1
                NSLog("select -- way1")
            }
            
        })
        let now = Date()
        print("time \( now.timeIntervalSince1970 - old.timeIntervalSince1970)")
        return result
        
    }
}
