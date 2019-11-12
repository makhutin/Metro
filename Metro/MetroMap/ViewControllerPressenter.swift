//
//  ViewControllerPressenter.swift
//  Metro
//
//  Created by Алексей Махутин on 11.11.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import Foundation

protocol ViewControllerPressenterProtocol {
    
    var data: [Int] { get set }
    var router: ViewControllerRouterProtocol! { get }
    
}
class ViewControllerPressenter: ViewControllerPressenterProtocol {
    
    weak var view: ViewController!
    var router: ViewControllerRouterProtocol!
    
    var data: [Int] = []
    
    init(viewcontroller: ViewController) {
        view = viewcontroller
    }
    
}
