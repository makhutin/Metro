//
//  FromToDriven.swift
//  Metro
//
//  Created by Алексей Махутин on 31.07.2020.
//  Copyright © 2020 Mahutin Aleksei. All rights reserved.
//

import UIKit

internal protocol FromToDrivenDelegate: AnyObject {
    func fromToDrivenDidFinishInteractive(_ fromToDriven: FromToDriven)
}

internal final class FromToDriven: UIPercentDrivenInteractiveTransition {

    var work = false
    weak var delegate: FromToDrivenDelegate?
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?

    override var wantsInteractiveStart: Bool {
        get {
            if self.work {
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
            return false
        }
        set {}
    }

    func configurate(_ vc: UIViewController) {
        self.presentedController = vc
        if let delegate = vc as? FromToDrivenDelegate {
            self.delegate = delegate
        }
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handle(_:)))
        if let panRecognizer = self.panRecognizer {
            vc.view.addGestureRecognizer(panRecognizer)
        }
    }

    override func finish() {
        super.finish()
        self.delegate?.fromToDrivenDidFinishInteractive(self)
    }

    @objc private func handle(_ recognizer: UIPanGestureRecognizer) {
        if self.work {
            switch recognizer.state {
            case .began:
                self.beginInteractiveDriven()
            case .changed:
                self.changedRecognizer(recognizer)
            case .ended, .cancelled:
                self.endInteractiveDriven(recognizer)
            case .failed:
                self.cancel()
            default:
                break
            }
        }
    }

    private func beginInteractiveDriven() {
        self.pause()
        if self.percentComplete == 0 {
            self.presentedController?.dismiss(animated: true)
        }
    }

    private func endInteractiveDriven(_ recognizer: UIPanGestureRecognizer) {
        let futureLocation = recognizer.velocity(in: self.presentedController?.view).y * 0.2
            + recognizer.translation(in: self.presentedController?.view).y
        let needFinishVelocity = futureLocation > (self.presentedController?.view.frame.height ?? 0 / 2)
        let needFinishPercent = self.percentComplete > 0.3
        if needFinishVelocity || needFinishPercent,
            recognizer.velocity(in: self.presentedController?.view).y > 0 {
            self.finish()
        } else {
            self.cancel()
        }
    }

    private func changedRecognizer(_ recognizer: UIPanGestureRecognizer) {
        let touchPosition = recognizer.translation(in: self.presentedController?.view)
        let coffiecent = touchPosition.y / (self.presentedController?.view.frame.height ?? 0)
        self.update(coffiecent)
    }
}
