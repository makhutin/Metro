//
//  TriangleView.swift
//  Metro
//
//  Created by Алексей Махутин on 28.10.2019.
//  Copyright © 2019 Mahutin Aleksei. All rights reserved.
//

import UIKit

@IBDesignable
class TriangleView: UIView {
    
    var color: UIColor = .green {
        didSet { self.setNeedsDisplay() }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.isOpaque = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()

        context.setFillColor(color.cgColor)
        context.fillPath()
    }
    
}
