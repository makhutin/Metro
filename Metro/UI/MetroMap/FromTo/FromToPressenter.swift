//
//  FromToPressenter.swift
//  Metro
//
//  Created by Алексей Махутин on 28.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal struct MetroStationInfo {
    let name: String
    let color: UIColor
    let lineNumber: Int
    let id: Int
}

internal protocol FromToPressenterProtocol {
    var info: MetroStationInfo? { get }
}

internal final class FromToPressenter: FromToPressenterProtocol {
    
    weak var vc: UIViewController?
    
    var info: MetroStationInfo?
    
    init(vc: UIViewController) {
        self.vc = vc
    }
}
