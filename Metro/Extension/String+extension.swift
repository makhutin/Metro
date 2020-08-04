//
//  String+extension.swift
//  Metro
//
//  Created by Алексей Махутин on 28.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import Foundation

extension String {
    static func get(_ forKey: LocalizedKeys) -> String {
        return NSLocalizedString(forKey.rawValue, comment: "")
    }

    static func getCap(_ forKey: LocalizedKeys) -> String {
        let text = NSLocalizedString(forKey.rawValue, comment: "")
        return text.capitalized
    }

    static func getCapFirtLetter(_ forKey: LocalizedKeys) -> String {
        let text = NSLocalizedString(forKey.rawValue, comment: "")
        return text.capitalizingFirstLetter()
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
