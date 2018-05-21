//
//  AnimatedShareButton.swift
//  PartsProtein
//
//  Created by attom on 21.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore

class AnimatedShareButton: UIButton {
    
    var box = CAShapeLayer()
    var leftShoulder = CAShapeLayer()
    var rightShoulder = CAShapeLayer()
    var arrow = CAShapeLayer()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lineWidth = CGFloat(1.5)
        
        box.path = {
            var path = CGMutablePath()
            path.move(to: CGPoint(x: frame.size.width - lineWidth/2, y: frame.size.height * 0.2))
            path.addLine(to: CGPoint(x: lineWidth/2, y: frame.size.height * 0.2))
            path.addLine(to: CGPoint(x: lineWidth/2, y: frame.size.height - lineWidth/2))
            path.addLine(to: CGPoint(x: frame.size.width - lineWidth/2, y: frame.size.height - lineWidth/2))
            return path
        }()
        
        arrow.path = {
           var path = CGMutablePath()
            path.move(to:CGPoint(x: frame.size.width * 0.5 - lineWidth/2, y: 0))
            path.addLine(to: CGPoint(x: frame.size.width * 0.5 - lineWidth/2, y: frame.size.width * 0.7))
            return path
        }()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
