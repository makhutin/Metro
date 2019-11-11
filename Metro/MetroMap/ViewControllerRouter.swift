//
//  ViewControllerRouter.swift
//  Metro
//
//  Created by Алексей Махутин on 11.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

protocol ViewControllerRouterProtocol {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class ViewControllerRouter: ViewControllerRouterProtocol {
    
    weak var viewController: ViewController!
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // show more table view and send data
        if let vc = segue.destination as? MoreTableView, segue.identifier == "MoreTableView"{
            vc.configurator.setData(data: viewController.presenter.data)
        }
    }
}
