//
//  MultiPoint.swift
//  Metro
//
//  Created by Алексей Махутин on 13.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

struct MultiPoint: Decodable {
    
    let coords: CGPoint
    let id: [Int]
    
    enum CodingKeys: String, CodingKey {
        case x,y,id,coords
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let coords = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coords)
        let x = try coords.decode(Double.self, forKey: .x)
        let y = try coords.decode(Double.self, forKey: .y)
        id = try container.decode(Array<Int>.self, forKey: .id)
        self.coords = CGPoint(x: x, y: y)
    }
}
