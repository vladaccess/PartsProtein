//
//  MeasureViewController.swift
//  PartsProtein
//
//  Created by attom on 21.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import pop

class MeasureViewController: OverboardViewController {
    
    @IBOutlet weak var grammCheck:UIImageView!
    
    
    let userDefaults = UserDefaults.groupUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grammCheck.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    }
    
    override func updateUI() {
        let unit = Constants.UnitOfMeasure(rawValue: userDefaults.integer(forKey: Constants.General.unitOfMeasure.key()))
        
        let slideUp = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        slideUp?.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
        slideUp?.toValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        slideUp?.removedOnCompletion = true
        
        let slideDown = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        slideDown?.fromValue = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        slideDown?.toValue = NSValue(cgPoint: CGPoint(x: 0, y: 0))
        slideDown?.removedOnCompletion = true

        if unit == Constants.UnitOfMeasure.gramm {
            grammCheck.pop_add(slideUp, forKey: "SLIDE_UP")
            Settings.registerDefaultsForGramm()
        }
    }
    
    
    @IBAction func grammCheckAction() {
        userDefaults.set(Constants.UnitOfMeasure.gramm.rawValue, forKey: Constants.General.unitOfMeasure.key())
        userDefaults.synchronize()
        updateUI()
    }
    

}
