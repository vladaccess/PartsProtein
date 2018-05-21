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
            let slideIn = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideIn?.fromValue = calendarConstraints.constant
            slideIn?.toValue = 40.0
            slideIn?.removedOnCompletion = true
            slideIn?.springBounciness = 5
            slideIn?.springSpeed = 8
            slideIn?.beginTime = CACurrentMediaTime() + 0.35
            calendarConstraints.pop_add(slideIn, forKey: "SlideInCalendar")
            
            var slideOut = POPBasicAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideOut?.fromValue = quantityLabelConstraint.constant
            slideOut?.toValue = view.frame.size.height
            slideOut?.removedOnCompletion = true
            slideOut?.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
            slideOut?.beginTime = CACurrentMediaTime() + 0.20
            quantityLabelConstraint.pop_add(slideOut, forKey: "SlideOutQuentity")
            
            slideOut = POPBasicAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideOut?.fromValue = daysLabelConstraint.constant
            slideOut?.toValue = view.frame.size.height
            slideOut?.removedOnCompletion = true
            slideOut?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            slideOut?.beginTime = CACurrentMediaTime() + 0.10
            daysLabelConstraint.pop_add(slideOut, forKey: "SlideOutDays")
            
            slideOut = POPBasicAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideOut?.fromValue = shareButtonConstaints.constant
            slideOut?.toValue = view.frame.size.height
            slideOut?.removedOnCompletion = true
            slideOut?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            shareButtonConstaints.pop_add(slideOut, forKey: "SlideOutButton")
            
            slideOut?.completionBlock = {
                (_,_) in
                self.animating = false
                self.showingStats = false
            }
            
        }else {
            let slideOut = POPBasicAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideOut?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            slideOut?.fromValue = calendarConstraints.constant
            slideOut?.toValue = -view.frame.size.height
            slideOut?.duration = 0.6
            slideOut?.removedOnCompletion = true
            calendarConstraints.pop_add(slideOut, forKey: "SlideOut")
            
            var slideIn = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideIn?.fromValue = quantityLabelConstraint.constant
            slideIn?.toValue = quantityLabelStartingConstant
            slideIn?.removedOnCompletion = true
            slideIn?.springBounciness = 5
            slideIn?.springSpeed = 8
            slideIn?.beginTime = CACurrentMediaTime() + 0.35
            quantityLabelConstraint.pop_add(slideIn, forKey: "SlideInQuantity")
            
            
            slideIn = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideIn?.fromValue = daysLabelConstraint.constant
            slideIn?.toValue = daysLabelStartingConstant
            slideIn?.removedOnCompletion = true
            slideIn?.springBounciness = 5
            slideIn?.springSpeed = 8
            slideIn?.beginTime = CACurrentMediaTime() + 0.5
            daysLabelConstraint.pop_add(slideIn, forKey: "SlideInDays")
            
            slideIn = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
            slideIn?.fromValue = shareButtonConstaints.constant
            slideIn?.toValue = shareButtonStartingConstant
            slideIn?.removedOnCompletion = true
            slideIn?.springBounciness = 5
            slideIn?.springSpeed = 8
            slideIn?.beginTime = CACurrentMediaTime() + 0.8
            shareButtonConstaints.pop_add(slideIn, forKey: "SlideInShareButton")
            
            slideIn?.completionBlock = {
                (_,_) in
                self.showingStats = true
                self.animating = false
            }
        }
        
        
        
    }
}
