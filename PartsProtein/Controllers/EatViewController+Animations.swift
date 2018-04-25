//
//  EatViewController+Animations.swift
//  PartsProtein
//
//  Created by attom on 26.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit

extension EatViewController {
    func initAnimation() {
        smallButton.alpha = 0
        largeButton.alpha = 0
        starButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    }
}
