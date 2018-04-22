//
//  WeightViewController.swift
//  PartsProtein
//
//  Created by attom on 21.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import pop

class WeightViewController:OverboardViewController,UITextFieldDelegate{
    
    @IBOutlet weak var weightTextField:UITextField!
    @IBOutlet weak var backgroundViewWeight:UIView!
    @IBOutlet weak var header:UILabel!
    
    let userDefaults = UserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        weightTextField.inputAccessoryView = Global.numericToolBar(self, selector: #selector(acceptAndSave))
        backgroundViewWeight.addGestureRecognizer(UITapGestureRecognizer(target: self.weightTextField, action: #selector(UIResponder.becomeFirstResponder)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func updateUI() {
        var numberFormatter:NumberFormatter {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        
        self.weightTextField.text = numberFormatter.string(for: userDefaults.double(forKey: Constants.Part.weight.key()))
        
    }

    @objc func acceptAndSave() {
        weightTextField.resignFirstResponder()
        var numberFormatter:NumberFormatter {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        var weight = 0.0
        if let number = numberFormatter.number(from: self.weightTextField.text ?? "0") {
            weight = number.doubleValue
        }
        
        userDefaults.set(weight, forKey: Constants.Part.weight.key())
        userDefaults.synchronize()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weightTextField.resignFirstResponder()
        acceptAndSave()
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        weightTextField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow() {
        self.scrollToView(from: 0, offset: -(self.header.frame.size.height + self.header.frame.origin.y))
    }
    
    @objc func keyboardWillHide() {
        self.scrollToView(from: -(self.header.frame.size.height + self.header.frame.origin.y), offset: 0)
    }
    
    
    
    func scrollToView(from:CGFloat,offset:CGFloat) {
        let animate = POPBasicAnimation(propertyNamed: kPOPLayerTranslationY)
        animate?.fromValue = from
        animate?.toValue = offset
        animate?.removedOnCompletion = true
        self.view.layer.pop_add(animate, forKey: "move")
    }
    
    

}
