//
//  StationInfo.swift
//  Metro
//
//  Created by Алексей Махутин on 11.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

struct StationInfo {
    enum StationInfoConfig {
        case start, end, normal, transfer, donat
    }
    let name: String
    let time: Date
    let type: StationInfoConfig
    let color: UIColor
}
