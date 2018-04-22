//
//  GoalViewController.swift
//  PartsProtein
//
//  Created by attom on 22.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit

class GoalViewController: OverboardViewController,UITextFieldDelegate {
    
    @IBOutlet weak var goalTF:UITextField!
    @IBOutlet weak var backgroundViewGoal:UIView!
    
    
    let userDefaults = UserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        goalTF.inputAccessoryView = Global.numericToolBar(self, selector: #selector(dismissAndSave))
        
        backgroundViewGoal.addGestureRecognizer(UITapGestureRecognizer(target: self.goalTF, action: #selector(UIResponder.becomeFirstResponder)))
    }
    
    override func updateUI() {
        var numberFormatter:NumberFormatter {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        
        goalTF.text = numberFormatter.string(for: userDefaults.double(forKey: Constants.Part.goal.key()))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        goalTF.resignFirstResponder()
        dismissAndSave()
        return true
    }
    
    @objc func dismissAndSave() {
        goalTF.resignFirstResponder()
        var numberFormatter:NumberFormatter {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        
        var goal = 0.0
        
        if let number = numberFormatter.number(from: goalTF.text ?? "0") {
            goal = number.doubleValue
        }
        userDefaults.set(goal, forKey: Constants.Part.goal.key())
        userDefaults.synchronize()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        goalTF.resignFirstResponder()
    }



}
