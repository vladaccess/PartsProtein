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
    
    func animateStarButton() {
        let rotate = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        rotate?.toValue = Double.pi * 2 - Double.pi/8
        rotate?.springBounciness = 5
        rotate?.removedOnCompletion = true
        starButton.layer.pop_add(rotate, forKey: "ROTATE")
        
        let scale = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        scale?.toValue = NSValue(cgPoint: CGPoint(x: 0.8, y: 0.8))
        scale?.springBounciness = 5
        scale?.removedOnCompletion = true
        starButton.pop_add(scale, forKey: "SCALE")
        scale?.completionBlock = {
            (_,_) in
            let sway = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
            sway?.fromValue = -Double.pi/8
            sway?.toValue = Double.pi
            sway?.duration = 0.75
            sway?.autoreverses = true
            sway?.repeatForever = true
            self.starButton.layer.pop_add(sway, forKey: "SWAY")
        }
    }
    
    func contractAddButton() {
        addButton.isUserInteractionEnabled = false
        [smallButton,largeButton].forEach { $0?.isUserInteractionEnabled = false }
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
        
        
        
        for button in [smallButton,largeButton] {
            let pop = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            pop?.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
            pop?.toValue = NSValue(cgPoint: CGPoint(x: 0.1, y: 0.1))
            pop?.springBounciness = 5
            pop?.removedOnCompletion = true
            button?.pop_add(pop, forKey: "pop")
        }
        
        
        
        
        let left = POPBasicAnimation(propertyNamed: kPOPLayerTranslationX)
        left?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        left?.fromValue = -100
        left?.toValue = 0
        self.smallButton.layer.pop_add(left, forKey: "left")
        
        
        let right = POPBasicAnimation(propertyNamed: kPOPLayerTranslationX)
        right?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        right?.fromValue = 100
        right?.toValue = 0
        self.largeButton.layer.pop_add(right, forKey: "right")
        
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
        
        
        [smallButton,largeButton].forEach { $0?.alpha = 1 }
        
        for button in [smallButton,largeButton] {
            let pop = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            pop?.fromValue = NSValue(cgPoint: CGPoint(x: 0.1, y: 0.1))
            pop?.toValue = NSValue(cgPoint: CGPoint(x: 1.0, y: 1.0))
            pop?.springBounciness = 5
            pop?.removedOnCompletion = true
            button?.pop_add(pop, forKey: "pop")
        }
        
        
        let left = POPSpringAnimation(propertyNamed: kPOPLayerTranslationX)
        left?.fromValue = 0
        left?.toValue = -100
        left?.springBounciness = 5
        self.smallButton.layer.pop_add(left, forKey: "left")
        
        
        let right = POPSpringAnimation(propertyNamed: kPOPLayerTranslationX)
        right?.fromValue = 0
        right?.toValue = 100
        right?.springBounciness = 5
        self.largeButton.layer.pop_add(right, forKey: "right")
        
        
    }
}
