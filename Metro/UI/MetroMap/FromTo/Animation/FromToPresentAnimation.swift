//
//  FromToPresentAnimation.swift
//  Metro
//
//  Created by Алексей Махутин on 30.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal final class FromToPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private enum Constants {
        static let duration: TimeInterval = 0.25
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let endOrigin = containerView.frame.origin
        let startingOrigin = CGPoint(x: endOrigin.x, y: UIScreen.main.bounds.height)

        containerView.frame.origin = startingOrigin

        let animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .easeOut) {
            containerView.frame.origin = endOrigin
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
