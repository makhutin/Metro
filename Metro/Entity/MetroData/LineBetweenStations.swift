//
//  LineBetweenStations.swift
//  Metro
//
//  Created by Алексей Махутин on 24.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

struct LineBetweenStations: Decodable {
    let fromId: Int
    let toId: Int
    
    enum CodingKeys: String, CodingKey {
        case from, to
    }
    
    init(fromId: Int, toId: Int) {
        self.fromId = fromId
        self.toId = toId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromId = try container.decode(Int.self, forKey: .from)
        toId = try container.decode(Int.self, forKey: .to)
    }
}
