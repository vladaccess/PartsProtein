//
//  CalendarViewController+Animations.swift
//  PartsProtein
//
//  Created by attom on 14.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import pop

extension CalendarViewController {
    func initAnimations() {
        quantityLabelStartingConstant = Double(quantityLabelConstraint.constant)
        quantityLabelConstraint.constant = view.frame.size.height
        
        daysLabelStartingConstant = Double(daysLabelConstraint.constant)
        daysLabelConstraint.constant = view.frame.size.height
        
        shareButtonStartingConstant = Double(shareButtonConstaints.constant)
        shareButtonConstaints.constant = view.frame.size.height
    }
    
    func animateShareView() {
        if animating {
            return
        }
        
        animating = true
        
        if showingStats {
            
        }else {
            let slideOut = POPBasicAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideOut?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            slideOut?.fromValue = calendarConstraints.constant
            slideOut?.toValue = -view.frame.size.height
            slideOut?.duration = 0.6
            slideOut?.removedOnCompletion = true
            calendarConstraints.pop_add(slideOut, forKey: "SlideOut")
            
            let slideIn = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideIn?.fromValue = quantityLabelConstraint.constant
            slideIn?.toValue = quantityLabelStartingConstant
            slideIn?.removedOnCompletion = true
            slideIn?.springBounciness = 5
            slideIn?.springSpeed = 8
            slideIn?.beginTime = CACurrentMediaTime() + 0.35
            quantityLabelConstraint.pop_add(slideIn, forKey: "SlideInQuantity")
            
        }
        
        
        
    }
}
