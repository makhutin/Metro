//
//  MetroData.swift
//  Metro
//
//  Created by Алексей Махутин on 13.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

struct MetroData: Decodable {
    
    let stations: [Station]
    let multiPoints: [MultiPoint]
    let lines: [[LineBetweenStations]]
    let colors: [LineColor]
    
    
}
