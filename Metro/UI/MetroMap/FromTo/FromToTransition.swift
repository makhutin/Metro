//
//  FromToTransition.swift
//  Metro
//
//  Created by Алексей Махутин on 28.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal final class FromToTransition: NSObject, UIViewControllerTransitioningDelegate {

    var driven: FromToDriven?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        self.driven = FromToDriven()
        self.driven?.configurate(presented)
        let presentationController = FromToPresentationController(presentedViewController: presented, presenting: presenting ?? source)
        presentationController.driven = self.driven
        return presentationController
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FromToPresentAnimation()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FromToDismissAnimation()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.driven
    }
}
