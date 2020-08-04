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
    func presentFromToVC(info: MetroStationInfo)
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

    func presentFromToVC(info: MetroStationInfo) {
        let workItem = DispatchWorkItem {
            let configurator = FromToConfigurator()
            let fromTo = FromToViewController()
            fromTo.delegate = self.viewController.metroView

            configurator.configure(with: fromTo, info: info)
            self.viewController.present(fromTo, animated: true, completion: nil)
        }

        if self.viewController.presentedViewController == nil {
            DispatchQueue.main.async(execute: workItem)
        } else {
            self.viewController.presentedViewController?.dismiss(animated: false, completion: {
                DispatchQueue.main.async(execute: workItem)
            })
        }
    }
}
