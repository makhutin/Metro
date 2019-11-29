//
//  MetroViewInteractor.swift
//  Metro
//
//  Created by Алексей Махутин on 31.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation


protocol MetroViewInteractorProtocol {
    var getStations: [Int :Station] { get }
    var getLines: [[LineBetweenStations]] { get }
    var getMultiStations: [MultiPoint] { get }
    var getLineColor: [LineColor] { get }
}

class MetroViewInteractor: MetroViewInteractorProtocol {
    
    private var data: MetroData!
    private var stationsDictionary: [Int: Station] = [:]
    
    private let router = RouteBuilder.share
    
    init() {
        data = DataFetcher.share.getMetroData()
        data.stations.forEach{
            stationsDictionary.updateValue($0, forKey: $0.id)
        }
    }
    
    var getStations: [Int: Station] {
        return stationsDictionary
    }
    
    var getLines: [[LineBetweenStations]] {
        return data.lines
    }
    
    var getMultiStations: [MultiPoint] {
        return data.multiPoints
    }
    
    var getLineColor: [LineColor] {
        return data.colors
    }
    
    func findRoute(from: Int, to: Int) -> [Int] {
        return router.buildPath(start: from, end: to)
    }
}
