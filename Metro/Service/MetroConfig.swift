//
//  MetroConfig.swift
//  Metro
//
//  Created by Mahutin Aleksei on 18/09/2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation
import UIKit

class MetroConfig {
    
    static let share = MetroConfig()
    private init() {}
    
    let allStations = [
        1:MetroStation(coords: CGPoint(x: 20, y: 95), id: 1, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        2:MetroStation(coords: CGPoint(x: 20, y: 91), id: 2, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        3:MetroStation(coords: CGPoint(x: 20, y: 87), id: 3, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        4:MetroStation(coords: CGPoint(x: 20, y: 83), id: 4, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        5:MetroStation(coords: CGPoint(x: 27, y: 77), id: 5, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        6:MetroStation(coords: CGPoint(x: 33, y: 72), id: 6, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        7:MetroStation(coords: CGPoint(x: 40.8, y: 64.55), id: 7, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: true),
        8:MetroStation(coords: CGPoint(x: 51, y: 55.17), id: 8, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: true),
        9:MetroStation(coords: CGPoint(x: 57.7, y: 48.47), id: 9, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: true),
        10:MetroStation(coords: CGPoint(x: 57.7, y: 40.5), id: 10, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: true),
        11:MetroStation(coords: CGPoint(x: 59, y: 36), id: 11, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        12:MetroStation(coords: CGPoint(x: 59, y: 32), id: 12, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        13:MetroStation(coords: CGPoint(x: 59, y: 28), id: 13, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        14:MetroStation(coords: CGPoint(x: 59, y: 24), id: 14, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        15:MetroStation(coords: CGPoint(x: 59, y: 20), id: 15, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        16:MetroStation(coords: CGPoint(x: 59, y: 16), id: 16, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        17:MetroStation(coords: CGPoint(x: 59, y: 12), id: 17, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        18:MetroStation(coords: CGPoint(x: 59, y: 8), id: 18, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        19:MetroStation(coords: CGPoint(x: 59, y: 4.4), id: 19, color: UIColor(red: 212/255, green: 33/255, blue: 61/255, alpha: 1), multi: false),
        20:MetroStation(coords: CGPoint(x: 42, y: 96), id: 20, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        21:MetroStation(coords: CGPoint(x: 42, y: 92), id: 21, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        22:MetroStation(coords: CGPoint(x: 42, y: 87.5), id: 22, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        23:MetroStation(coords: CGPoint(x: 42, y: 83.5), id: 23, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        24:MetroStation(coords: CGPoint(x: 42, y: 79), id: 24, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        25:MetroStation(coords: CGPoint(x: 42, y: 75.5), id: 25, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        26:MetroStation(coords: CGPoint(x: 42, y: 70.5), id: 26, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        27:MetroStation(coords: CGPoint(x: 43.25, y: 64.55), id: 27, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: true),
        28:MetroStation(coords: CGPoint(x: 41.3, y: 49.56), id: 28, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: true),
        29:MetroStation(coords: CGPoint(x: 40.8, y: 40.47), id: 29, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: true),
        30:MetroStation(coords: CGPoint(x: 42, y: 34), id: 30, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        31:MetroStation(coords: CGPoint(x: 42, y: 30), id: 31, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        32:MetroStation(coords: CGPoint(x: 42, y: 26), id: 32, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        33:MetroStation(coords: CGPoint(x: 42, y: 22), id: 33, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        34:MetroStation(coords: CGPoint(x: 42, y: 18), id: 34, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        35:MetroStation(coords: CGPoint(x: 42, y: 14), id: 35, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        36:MetroStation(coords: CGPoint(x: 42, y: 10), id: 36, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        37:MetroStation(coords: CGPoint(x: 42, y: 4.4), id: 37, color: UIColor(red: 19/255, green: 127/255, blue: 201/255, alpha: 1), multi: false),
        38:MetroStation(coords: CGPoint(x: 76, y: 95), id: 38, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        39:MetroStation(coords: CGPoint(x: 76, y: 88), id: 39, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        40:MetroStation(coords: CGPoint(x: 76, y: 81), id: 40, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        41:MetroStation(coords: CGPoint(x: 76, y: 74), id: 41, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        42:MetroStation(coords: CGPoint(x: 76, y: 67), id: 42, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        43:MetroStation(coords: CGPoint(x: 74.7, y: 48.47), id: 43, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: true),
        44:MetroStation(coords: CGPoint(x: 60.25, y: 40.5), id: 44, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: true),
        45:MetroStation(coords: CGPoint(x: 43.25, y: 40.5), id: 45, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: true),
        46:MetroStation(coords: CGPoint(x: 17, y: 40.5), id: 46, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        47:MetroStation(coords: CGPoint(x: 10, y: 34), id: 47, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        48:MetroStation(coords: CGPoint(x: 10, y: 27), id: 48, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        49:MetroStation(coords: CGPoint(x: 10, y: 20), id: 49, color: UIColor(red: 21/255, green:  152/255, blue: 91/255, alpha: 1), multi: false),
        50:MetroStation(coords: CGPoint(x: 93, y: 76), id: 50, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: false),
        51:MetroStation(coords: CGPoint(x: 93, y: 70), id: 51, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: false),
        52:MetroStation(coords: CGPoint(x: 93, y: 65), id: 52, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: false),
        53:MetroStation(coords: CGPoint(x: 93, y: 60), id: 53, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: false),
        54:MetroStation(coords: CGPoint(x: 77.2, y: 48.47), id: 54, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: true),
        55:MetroStation(coords: CGPoint(x: 67.5, y: 48.5), id: 55, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: false),
        56:MetroStation(coords: CGPoint(x: 60.35, y: 48.47), id: 56, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: true),
        57:MetroStation(coords: CGPoint(x: 43.2, y: 48.4), id: 57, color: UIColor(red: 220/255, green: 112/255, blue: 33/255, alpha: 1), multi: true),
        58:MetroStation(coords: CGPoint(x: 59, y: 85), id: 58, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        59:MetroStation(coords: CGPoint(x: 59, y: 78), id: 59, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        60:MetroStation(coords: CGPoint(x: 59, y: 72), id: 60, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        61:MetroStation(coords: CGPoint(x: 59, y: 60), id: 61, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        62:MetroStation(coords: CGPoint(x: 53.5, y: 55.17), id: 62, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: true),
        63:MetroStation(coords: CGPoint(x: 41.3, y: 47.68), id: 63, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: true),
        64:MetroStation(coords: CGPoint(x: 36, y: 43.5), id: 64, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        65:MetroStation(coords: CGPoint(x: 25, y: 34), id: 65, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        66:MetroStation(coords: CGPoint(x: 25, y: 28.5), id: 66, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        67:MetroStation(coords: CGPoint(x: 25, y: 23), id: 67, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        68:MetroStation(coords: CGPoint(x: 25, y: 16.5), id: 68, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        69:MetroStation(coords: CGPoint(x: 25, y: 10), id: 69, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
        70:MetroStation(coords: CGPoint(x: 20, y: 36), id: 70, color: UIColor(red: 109/255, green: 20/255, blue: 118/255, alpha: 1), multi: false),
    ]
    
    let link = [
        1:[LinkWithTime(id: 2, time: 120)],
        2:[LinkWithTime(id: 1, time: 120),LinkWithTime(id: 3, time: 180)],
        3:[LinkWithTime(id: 2, time: 180),LinkWithTime(id: 4, time: 120)],
        4:[LinkWithTime(id: 3, time: 120),LinkWithTime(id: 5, time: 240)],
        5:[LinkWithTime(id: 4, time: 240),LinkWithTime(id: 6, time: 180)],
        6:[LinkWithTime(id: 5, time: 180),LinkWithTime(id: 7, time: 180)],
        7:[LinkWithTime(id: 6, time: 180),LinkWithTime(id: 8, time: 120),LinkWithTime(id: 27, time: 120)],
        8:[LinkWithTime(id: 7, time: 120),LinkWithTime(id: 9, time: 120),LinkWithTime(id: 62, time: 180)],
        9:[LinkWithTime(id: 8, time: 120),LinkWithTime(id: 10, time: 120),LinkWithTime(id: 56, time: 180)],
        10:[LinkWithTime(id: 9, time: 120),LinkWithTime(id: 11, time: 120),LinkWithTime(id: 44, time: 180)],
        11:[LinkWithTime(id: 10, time: 120),LinkWithTime(id: 12, time: 180)],
        12:[LinkWithTime(id: 11, time: 180),LinkWithTime(id: 13, time: 120)],
        13:[LinkWithTime(id: 12, time: 120),LinkWithTime(id: 14, time: 120)],
        14:[LinkWithTime(id: 13, time: 120),LinkWithTime(id: 15, time: 180)],
        15:[LinkWithTime(id: 14, time: 180),LinkWithTime(id: 16, time: 180)],
        16:[LinkWithTime(id: 15, time: 180),LinkWithTime(id: 17, time: 180)],
        17:[LinkWithTime(id: 16, time: 180),LinkWithTime(id: 18, time: 120)],
        18:[LinkWithTime(id: 17, time: 120),LinkWithTime(id: 19, time: 120)],
        19:[LinkWithTime(id: 18, time: 120)],
        20:[LinkWithTime(id: 21, time: 180)],
        21:[LinkWithTime(id: 20, time: 180),LinkWithTime(id: 22, time: 240)],
        22:[LinkWithTime(id: 21, time: 240),LinkWithTime(id: 23, time: 180)],
        23:[LinkWithTime(id: 22, time: 180),LinkWithTime(id: 24, time: 120)],
        24:[LinkWithTime(id: 23, time: 120),LinkWithTime(id: 25, time: 120)],
        25:[LinkWithTime(id: 24, time: 120),LinkWithTime(id: 26, time: 120)],
        26:[LinkWithTime(id: 25, time: 120),LinkWithTime(id: 27, time: 120)],
        27:[LinkWithTime(id: 26, time: 120),LinkWithTime(id: 28, time: 180),LinkWithTime(id: 7, time: 120)],
        28:[LinkWithTime(id: 27, time: 180),LinkWithTime(id: 29, time: 120),LinkWithTime(id: 63, time: 180),LinkWithTime(id: 57, time: 180)],
        29:[LinkWithTime(id: 28, time: 120),LinkWithTime(id: 30, time: 240),LinkWithTime(id: 45, time: 180)],
        30:[LinkWithTime(id: 29, time: 240),LinkWithTime(id: 31, time: 120)],
        31:[LinkWithTime(id: 30, time: 120),LinkWithTime(id: 32, time: 240)],
        32:[LinkWithTime(id: 31, time: 240),LinkWithTime(id: 33, time: 180)],
        33:[LinkWithTime(id: 32, time: 180),LinkWithTime(id: 34, time: 180)],
        34:[LinkWithTime(id: 33, time: 180),LinkWithTime(id: 35, time: 180)],
        35:[LinkWithTime(id: 34, time: 180),LinkWithTime(id: 36, time: 120)],
        36:[LinkWithTime(id: 35, time: 120),LinkWithTime(id: 37, time: 180)],
        37:[LinkWithTime(id: 36, time: 180)],
        38:[LinkWithTime(id: 39, time: 240)],
        39:[LinkWithTime(id: 38, time: 240),LinkWithTime(id: 40, time: 180)],
        40:[LinkWithTime(id: 39, time: 180),LinkWithTime(id: 41, time: 180)],
        41:[LinkWithTime(id: 40, time: 180),LinkWithTime(id: 42, time: 180)],
        42:[LinkWithTime(id: 41, time: 180),LinkWithTime(id: 43, time: 300)],
        43:[LinkWithTime(id: 42, time: 300),LinkWithTime(id: 44, time: 180),LinkWithTime(id: 54, time: 180)],
        44:[LinkWithTime(id: 43, time: 180),LinkWithTime(id: 45, time: 180),LinkWithTime(id: 10, time: 180)],
        45:[LinkWithTime(id: 44, time: 180),LinkWithTime(id: 46, time: 240),LinkWithTime(id: 29, time: 180)],
        46:[LinkWithTime(id: 45, time: 240),LinkWithTime(id: 47, time: 240)],
        47:[LinkWithTime(id: 46, time: 240),LinkWithTime(id: 48, time: 240)],
        48:[LinkWithTime(id: 47, time: 240),LinkWithTime(id: 49, time: 240)],
        49:[LinkWithTime(id: 48, time: 240)],
        50:[LinkWithTime(id: 51, time: 180)],
        51:[LinkWithTime(id: 50, time: 180),LinkWithTime(id: 52, time: 180)],
        52:[LinkWithTime(id: 51, time: 180),LinkWithTime(id: 53, time: 180)],
        53:[LinkWithTime(id: 52, time: 180),LinkWithTime(id: 54, time: 180)],
        54:[LinkWithTime(id: 53, time: 180),LinkWithTime(id: 55, time: 120),LinkWithTime(id: 43, time: 180)],
        55:[LinkWithTime(id: 54, time: 120),LinkWithTime(id: 56, time: 120)],
        56:[LinkWithTime(id: 55, time: 120),LinkWithTime(id: 57, time: 240),LinkWithTime(id: 9, time: 180)],
        57:[LinkWithTime(id: 56, time: 240),LinkWithTime(id: 28, time: 180),LinkWithTime(id: 63, time: 180)],
        58:[LinkWithTime(id: 59, time: 180)],
        59:[LinkWithTime(id: 58, time: 180),LinkWithTime(id: 60, time: 180)],
        60:[LinkWithTime(id: 59, time: 180),LinkWithTime(id: 61, time: 180)],
        61:[LinkWithTime(id: 60, time: 180),LinkWithTime(id: 62, time: 180)],
        62:[LinkWithTime(id: 61, time: 180),LinkWithTime(id: 63, time: 240),LinkWithTime(id: 8, time: 180)],
        63:[LinkWithTime(id: 62, time: 240),LinkWithTime(id: 64, time: 180),LinkWithTime(id: 28, time: 180),LinkWithTime(id: 57, time: 180)],
        64:[LinkWithTime(id: 63, time: 180),LinkWithTime(id: 65, time: 180)],
        65:[LinkWithTime(id: 64, time: 180),LinkWithTime(id: 66, time: 120),LinkWithTime(id: 70, time: 240)],
        66:[LinkWithTime(id: 65, time: 120),LinkWithTime(id: 67, time: 240)],
        67:[LinkWithTime(id: 66, time: 240),LinkWithTime(id: 68, time: 180)],
        68:[LinkWithTime(id: 67, time: 180),LinkWithTime(id: 69, time: 180)],
        69:[LinkWithTime(id: 68, time: 180)],
        70:[LinkWithTime(id: 65, time: 240)]
    ]
    
    let lines = [0:[LineBetweenStations(fromId: 1, toId: 2),
                     LineBetweenStations(fromId: 2, toId: 3),
                     LineBetweenStations(fromId: 3, toId: 4),
                     LineBetweenStations(fromId: 4, toId: 5),
                     LineBetweenStations(fromId: 5, toId: 6),
                     LineBetweenStations(fromId: 6, toId: 7),
                     LineBetweenStations(fromId: 7, toId: 8),
                     LineBetweenStations(fromId: 8, toId: 9),
                     LineBetweenStations(fromId: 9, toId: 10),
                     LineBetweenStations(fromId: 10, toId: 11),
                     LineBetweenStations(fromId: 11, toId: 12),
                     LineBetweenStations(fromId: 12, toId: 13),
                     LineBetweenStations(fromId: 13, toId: 14),
                     LineBetweenStations(fromId: 14, toId: 15),
                     LineBetweenStations(fromId: 15, toId: 16),
                     LineBetweenStations(fromId: 16, toId: 17),
                     LineBetweenStations(fromId: 17, toId: 18),
                     LineBetweenStations(fromId: 18, toId: 19)],
                  1:[LineBetweenStations(fromId: 20, toId: 21),
                     LineBetweenStations(fromId: 21, toId: 22),
                     LineBetweenStations(fromId: 22, toId: 23),
                     LineBetweenStations(fromId: 23, toId: 24),
                     LineBetweenStations(fromId: 24, toId: 25),
                     LineBetweenStations(fromId: 25, toId: 26),
                     LineBetweenStations(fromId: 26, toId: 27),
                     LineBetweenStations(fromId: 27, toId: 28),
                     LineBetweenStations(fromId: 28, toId: 29),
                     LineBetweenStations(fromId: 29, toId: 30),
                     LineBetweenStations(fromId: 30, toId: 31),
                     LineBetweenStations(fromId: 31, toId: 32),
                     LineBetweenStations(fromId: 32, toId: 33),
                     LineBetweenStations(fromId: 33, toId: 34),
                     LineBetweenStations(fromId: 34, toId: 35),
                     LineBetweenStations(fromId: 35, toId: 36),
                     LineBetweenStations(fromId: 36, toId: 37),],
                  2:[LineBetweenStations(fromId: 38, toId: 39),
                     LineBetweenStations(fromId: 39, toId: 40),
                     LineBetweenStations(fromId: 40, toId: 41),
                     LineBetweenStations(fromId: 41, toId: 42),
                     LineBetweenStations(fromId: 42, toId: 43),
                     LineBetweenStations(fromId: 43, toId: 44),
                     LineBetweenStations(fromId: 44, toId: 45),
                     LineBetweenStations(fromId: 45, toId: 46),
                     LineBetweenStations(fromId: 46, toId: 47),
                     LineBetweenStations(fromId: 47, toId: 48),
                     LineBetweenStations(fromId: 48, toId: 49)],
                  3:[LineBetweenStations(fromId: 50, toId: 51),
                     LineBetweenStations(fromId: 51, toId: 52),
                     LineBetweenStations(fromId: 52, toId: 53),
                     LineBetweenStations(fromId: 53, toId: 54),
                     LineBetweenStations(fromId: 54, toId: 55),
                     LineBetweenStations(fromId: 55, toId: 56),
                     LineBetweenStations(fromId: 56, toId: 57)],
                  4:[LineBetweenStations(fromId: 58, toId: 59),
                     LineBetweenStations(fromId: 59, toId: 60),
                     LineBetweenStations(fromId: 60, toId: 61),
                     LineBetweenStations(fromId: 61, toId: 62),
                     LineBetweenStations(fromId: 62, toId: 63),
                     LineBetweenStations(fromId: 63, toId: 64),
                     LineBetweenStations(fromId: 64, toId: 65),
                     LineBetweenStations(fromId: 65, toId: 66),
                     LineBetweenStations(fromId: 66, toId: 67),
                     LineBetweenStations(fromId: 67, toId: 68),
                     LineBetweenStations(fromId: 68, toId: 69),
                     LineBetweenStations(fromId: 65, toId: 70)]
    ]
    
    
    let multiStation = [MetroMultiStation(coords: CGPoint(x: 40.5, y: 64.37), count: .two, id: [7,27]),
                        MetroMultiStation(coords: CGPoint(x: 40.5, y: 47.25), count: .three, id: [28,57,63]),
                        MetroMultiStation(coords: CGPoint(x: 40.5, y: 40.27), count: .two, id: [29,45]),
                        MetroMultiStation(coords: CGPoint(x: 57.5, y: 40.27), count: .two, id: [10,44]),
                        MetroMultiStation(coords: CGPoint(x: 57.5, y: 48.27), count: .two, id: [9,56]),
                        MetroMultiStation(coords: CGPoint(x: 74.5, y: 48.27), count: .two, id: [43,54]),
                        MetroMultiStation(coords: CGPoint(x: 50.8, y: 54.97), count: .two, id: [8,62]),
    ]
    
    let textStation = ["ru_RU":[1:"проспект ветеранов",
                             2:"ленинский проспект",
                             3:"автово",
                             4:"кировский завод",
                             5:"нарвская",
                             6:"балтийская",
                             7:"технологический институт 1",
                             8:"пушкинская",
                             9:"владимирская",
                             10:"площадь восстания",
                             11:"чернышевская",
                             12:"площадь ленина",
                             13:"выборская",
                             14:"лесная",
                             15:"площадь мужества",
                             16:"политехническая",
                             17:"академическая",
                             18:"граждансий проспект",
                             19:"девяткино",
                             20:"купчино",
                             21:"звёздная",
                             22:"московская",
                             23:"парк победы",
                             24:"электросила",
                             25:"московские ворота",
                             26:"фрузенская",
                             27:"технологический институт 2",
                             28:"сенная площадь",
                             29:"невский проспект",
                             30:"горьковкая",
                             31:"петроградская",
                             32:"чёрная речка",
                             33:"пионерская",
                             34:"удельная",
                             35:"озерки",
                             36:"проспект просвещения",
                             37:"парнас",
                             38:"рыбацкое",
                             39:"обухово",
                             40:"пролетарская",
                             41:"ломоносовская",
                             42:"елизаровская",
                             43:"площадь александра невского 1",
                             44:"маяковская",
                             45:"гостиный двор",
                             46:"василеостровская",
                             47:"приморская",
                             48:"новокрестовская",
                             49:"беговая",
                             50:"улица дыбенко",
                             51:"проспект большевиков",
                             52:"ладожская",
                             53:"новочеркасская",
                             54:"площадь александра невского 2",
                             55:"лиговский проспект",
                             56:"достоевская",
                             57:"спасская",
                             58:"международная",
                             59:"бухаретская",
                             60:"волковская",
                             61:"обводный канал",
                             62:"звенигородская",
                             63:"садовая",
                             64:"адмиралтейская",
                             65:"спортивная",
                             66:"чкаловская",
                             67:"крестовский остров",
                             68:"старая деревня",
                             69:"коменданский проспект"]]
    
    
}