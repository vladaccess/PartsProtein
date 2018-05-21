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
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
