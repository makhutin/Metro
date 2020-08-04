//
//  ViewControllerConfigurator.swift
//  Metro
//
//  Created by Алексей Махутин on 11.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

protocol ViewControllerConfiguratorProtocol {
    func configure(with viewController: ViewController)
}

class ViewControllerConfigurator: ViewControllerConfiguratorProtocol {
    
    func configure(with viewController: ViewController) {
        let presenter = ViewControllerPressenter(viewcontroller: viewController)
        let router = ViewControllerRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.router = router
    }
}
