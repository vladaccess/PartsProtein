//
//  CalendarViewController+Animations.swift
//  PartsProtein
//
//  Created by attom on 14.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation

extension CalendarViewController {
    func initAnimations() {
        quantityLabelStartingConstant = Double(quantityLabelConstraint.constant)
        quantityLabelConstraint.constant = view.frame.size.height
        
        daysLabelStartingConstant = Double(daysLabelConstraint.constant)
        daysLabelConstraint.constant = view.frame.size.height
        
        shareButtonStartingConstant = Double(shareButtonConstaints.constant)
        shareButtonConstaints.constant = view.frame.size.height
    }
}
