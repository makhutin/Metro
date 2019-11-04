//
//  MetroViewStyleAnim.swift
//  Metro
//
//  Created by Алексей Махутин on 04.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

enum MetroViewStyleAnimType {
    case tap, untap, route, unroute, normal
}

protocol MetroViewStyleAnim {
    
    func setStyle(style: MetroViewStyleAnimType)
    
}
