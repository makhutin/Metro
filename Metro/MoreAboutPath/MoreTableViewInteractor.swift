//
//  MoreTableViewInteractor.swift
//  Metro
//
//  Created by Алексей Махутин on 21.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

protocol MoreTableViewInteractorProtocol {
    var stations: [Int: Station] { get }
}

class MoreTableViewInteractor {
    
    let data = DataFetcher.share.getMetroData()
    
    var stationsDict: [Int: Station] = [:]
    
    init() {
        updateStationsDict()
    }
    
    func updateStationsDict() {
        data?.stations.forEach{
            stationsDict.updateValue($0, forKey: $0.id)
        }
    }
    
    var stations: [Int: Station] {
        return stationsDict
    }
}
