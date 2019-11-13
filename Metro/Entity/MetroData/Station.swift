//
//  Station.swift
//  Metro
//
//  Created by Алексей Махутин on 13.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

struct Station: Decodable {
    
    struct Edges: Decodable {
        let time: Int
        let id: Int
    }
    
    let id: Int
    let coords: CGPoint
    let multi: Bool
    let name: [String:String]
    let edges: [Edges]
    let line: Int
    
    enum CodingKeys: String, CodingKey {
        case id,coords,multi,name,edges,line,x,y
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        
        let coords = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coords)
        let x = try coords.decode(Double.self, forKey: .x)
        let y = try coords.decode(Double.self, forKey: .y)
        self.coords = CGPoint(x: x, y: y)
        
        multi = try container.decode(Bool.self,forKey: .multi)
        name = try container.decode([String:String].self, forKey: .name)
        edges = try container.decode([Edges].self, forKey: .edges)
        line = try container.decode(Int.self, forKey: .line)
        
    }
        
}

