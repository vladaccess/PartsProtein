//
//  EatViewController+Animations.swift
//  PartsProtein
//
//  Created by attom on 26.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import pop

extension EatViewController {
    func initAnimation() {
        smallButton.alpha = 0
        largeButton.alpha = 0
        starButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    }
    
    func contractAddButton() {
        addButton.isUserInteractionEnabled = false
        let rotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        rotate?.fromValue = -Double.pi + Double.pi/4
        rotate?.toValue = 0
        rotate?.springBounciness = 5
        rotate?.removedOnCompletion = true
        rotate?.completionBlock = {
            _,_ in
            self.addButton.isUserInteractionEnabled = true
            self.expanded = false
            [self.smallButton,self.largeButton].map { $0?.isUserInteractionEnabled = true }
        }
        
        let scale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scale?.fromValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
        scale?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        scale?.removedOnCompletion = true
        scale?.springBounciness = 5
        
        
        let color = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
        color?.fromValue = Tint.tint_destructive
        color?.toValue = Tint.mainTint
        color?.springBounciness = 5
        color?.removedOnCompletion = true
        
        let slideUp = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        slideUp?.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
        slideUp?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        slideUp?.springBounciness = 5
        slideUp?.removedOnCompletion = true
        
        
        self.minusButton.pop_add(slideUp, forKey: "slideUp")
        self.addButton.pop_add(color, forKey: "color")
        self.addButton.pop_add(scale, forKey: "scale")
        self.addButton.layer.pop_add(rotate, forKey: "rotate")
    }
    
    func expandedAddButton() {
        addButton.isUserInteractionEnabled = false
        let rotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        rotate?.fromValue = 0
        rotate?.toValue = -Double.pi + Double.pi/4
        rotate?.springBounciness = 5
        rotate?.removedOnCompletion = true
        rotate?.completionBlock = {
            _,_ in
            self.addButton.isUserInteractionEnabled = true
            self.expanded = true
            [self.smallButton,self.largeButton].map { $0?.isUserInteractionEnabled = true }
        }
        
        
        let scale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scale?.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        scale?.toValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
        scale?.springBounciness = 5
        scale?.removedOnCompletion = true
        
        
        let color = POPSpringAnimation(propertyNamed: kPOPViewBackgroundColor)
        color?.fromValue = Tint.mainTint
        color?.toValue = Tint.tint_destructive
        color?.springBounciness = 5
        color?.removedOnCompletion = true
        
        
        let slideDown = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        slideDown?.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        slideDown?.toValue =  NSValue(cgPoint: CGPoint(x: 0, y: 0))
        slideDown?.springBounciness = 5
        slideDown?.removedOnCompletion = true
        
        self.minusButton.pop_add(slideDown, forKey: "slideDown")
        self.addButton.pop_add(color, forKey: "color")
        self.addButton.pop_add(scale, forKey: "scale")
        self.addButton.layer.pop_add(rotate, forKey: "rotate")
        
    }
}
