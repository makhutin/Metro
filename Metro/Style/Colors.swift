//
//  Colors.swift
//  Metro
//
//  Created by Алексей Махутин on 29.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal enum Colors {
    case fromToViewController_background
    case fromToViewController_mainText
    case fromToViewController_buttonBackground
    case fromToViewController_buttonText
    case fromToViewController_shadowColor
    case fromToViewController_dragView
}

extension UIColor {
    static func getColor(_ colorKey: Colors) -> UIColor {
        let darkmode = UIViewController().traitCollection.userInterfaceStyle == .dark
        switch colorKey {
        case .fromToViewController_background:
            return darkmode ? .black : UIColor.white
        case .fromToViewController_mainText:
            return darkmode ? .white : .black
        case .fromToViewController_buttonText:
            return .white
        case .fromToViewController_buttonBackground:
            return .systemBlue
        case .fromToViewController_shadowColor:
            return darkmode ? .white : .black
        case .fromToViewController_dragView:
            return darkmode ? UIColor(white: 0.2, alpha: 1) : UIColor(white: 0.8, alpha: 1)
        }
    }
}
