//
//  FromToPresentationController.swift
//  Metro
//
//  Created by Алексей Махутин on 28.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal final class FromToPresentationController: UIPresentationController {

    var driven: FromToDriven?

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = self.presentingViewController.view.bounds
        let size = self.presentedViewController.preferredContentSize
        let safeButtomInset = self.presentingViewController.view.safeAreaInsets.bottom

        var width = bounds.width
        if self.presentingViewController.traitCollection.horizontalSizeClass == .regular,
            self.presentingViewController.traitCollection.verticalSizeClass == .regular {
            width = max(300, width / 3)
        }
        return CGRect(x: 0,
                      y: bounds.height - size.height - safeButtomInset,
                      width: width,
                      height: size.height + safeButtomInset)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let presentedView = self.presentedView else { return }

        self.containerView?.frame = self.frameOfPresentedViewInContainerView
        self.presentedView?.frame = self.containerView?.bounds ?? .zero
        self.containerView?.addSubview(presentedView)
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)

        if completed {
            self.driven?.work = true
        }
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()

        self.containerView?.frame = self.frameOfPresentedViewInContainerView
        let cornerRadius: CGFloat = 20
        let shadowFrame = (self.presentedView?.frame ?? .zero)
            .inset(by: UIEdgeInsets(top: -4, left: -1, bottom: 0, right: -1))
        self.presentedView?.layer.shadowPath = UIBezierPath(roundedRect: shadowFrame, cornerRadius: cornerRadius).cgPath
        self.presentedView?.layer.shadowRadius = 5
        self.presentedView?.layer.shadowOpacity = 0.2
        self.presentedView?.layer.cornerRadius = cornerRadius
        self.presentedView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.updateColor()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard #available(iOS 13.0, *) else { return }

        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            self.updateColor()
        }
    }

    private func updateColor() {
        self.presentedView?.layer.shadowColor = UIColor.getColor(.fromToViewController_shadowColor).cgColor
    }
}
