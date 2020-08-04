//
//  MoreTableViewConfigurator.swift
//  Metro
//
//  Created by Алексей Махутин on 11.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

protocol MoreTableViewConfiguratorProtocol {
    func configure(with viewController: MoreTableView)
    
    func setData(data: [Int])
}

class MoreTableViewConfigurator: MoreTableViewConfiguratorProtocol {
    
    private var data: [Int] = []
    
    func setData(data: [Int]) {
        self.data = data
    }
    
    func configure(with viewController: MoreTableView) {
        let presenter = MoreTableViewPresenter(viewcontroller: viewController, data: data)
        
        viewController.presenter = presenter
    }
}
