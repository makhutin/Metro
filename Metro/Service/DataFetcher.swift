//
//  DataFetcher.swift
//  Metro
//
//  Created by Алексей Махутин on 20.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

class DataFetcher {
    
    static let share = DataFetcher()
    
    private init() {}
    
    var data: MetroData?
    
    func getMetroData() -> MetroData? {
        if data != nil { return self.data }
        guard let data = DataLoader.share.laodFileToData(filename: "data", wtihExtension: "json") else { return nil }
        do {
            let result = try JSONDecoder().decode(MetroData.self, from: data)
            self.data = result
            return result
        }catch{
            NSLog("Failed to load metroData")
            return nil
        }
    }
}
