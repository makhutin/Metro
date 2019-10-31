//
//  MetroViewInteractor.swift
//  Metro
//
//  Created by Алексей Махутин on 31.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation


protocol MetroViewInteractorProtocol {
    var getStations: [Int : MetroStation] { get }
    var getLines: [Int : [LineBetweenStations]] { get }
    var getMultiStations: [MetroMultiStation] { get }
    
    func getText(language: String) -> [Int : String]
}

class MetroViewInteractor: MetroViewInteractorProtocol {
    
    private var stationsConfig = MetroConfig.share.allStations
    private var linesConfig = MetroConfig.share.lines
    private var textConfig = MetroConfig.share.textStation
    private let multiConfig = MetroConfig.share.multiStation
    
    var getStations: [Int : MetroStation] {
        return stationsConfig
    }
    
    var getLines: [Int : [LineBetweenStations]] {
        return linesConfig
    }
    
    var getMultiStations: [MetroMultiStation] {
        return multiConfig
    }
    
    func getText(language: String) -> [Int : String] {
        if let text = textConfig[language] {
            return text
        }
        return textConfig["ru_RU"]!
    }
}
