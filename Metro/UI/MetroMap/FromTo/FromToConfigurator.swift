//
//  FromToConfigurator.swift
//  Metro
//
//  Created by Алексей Махутин on 28.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal protocol FromToConfiguratorProtocol {
    func configure(with viewController: FromToViewController, info: MetroStationInfo)
}

internal final class FromToConfigurator: FromToConfiguratorProtocol {
    func configure(with viewController: FromToViewController, info: MetroStationInfo) {
        let presenter = FromToPressenter(vc: viewController)
        presenter.info = info
        viewController.presenter = presenter
    }
}
