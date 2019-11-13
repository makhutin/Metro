//
//  DataLoader.swift
//  Metro
//
//  Created by Алексей Махутин on 13.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

class DataLoader {
    
    static let share = DataLoader()
    
    private init () {}
    
    func laodFileToData(filename: String,wtihExtension: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: wtihExtension), let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
    
}
