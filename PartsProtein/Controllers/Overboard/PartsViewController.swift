//
//  PartsViewController.swift
//  PartsProtein
//
//  Created by attom on 22.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import pop

class PartsViewController: OverboardViewController,UITextFieldDelegate {
    
    @IBOutlet weak var smallPartTF:UITextField!
    @IBOutlet weak var bigPartTF:UITextField!
    @IBOutlet weak var backgroundViewSmall:UIView!
    @IBOutlet weak var backgroundViewBig:UIView!
    @IBOutlet weak var header:UILabel!
    
    let userDefaults = UserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        smallPartTF.inputAccessoryView = Global.numericToolBar(self, selector: #selector(dismissAndSave))
        bigPartTF.inputAccessoryView = Global.numericToolBar(self, selector: #selector(dismissAndSave))
        
        backgroundViewSmall.addGestureRecognizer(UITapGestureRecognizer(target: smallPartTF, action: #selector(UIResponder.becomeFirstResponder)))
        backgroundViewBig.addGestureRecognizer(UITapGestureRecognizer(target: bigPartTF, action: #selector(UIResponder.becomeFirstResponder)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
    }
    override func updateUI() {
        var numberFormatter:NumberFormatter {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        
        
        self.smallPartTF.text = numberFormatter.string(for: userDefaults.double(forKey: Constants.Part.small.key()))
        self.bigPartTF.text = numberFormatter.string(for: userDefaults.double(forKey: Constants.Part.big.key()))
    }
    
    @objc func dismissAndSave() {
        [smallPartTF,bigPartTF].map {$0?.resignFirstResponder()}
        var numberFormatter:NumberFormatter {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter
        }
        
        var small = 0.0
        var big = 0.0
        
        if let number = numberFormatter.number(from: smallPartTF.text ?? "0") {
            small = number.doubleValue
        }
        
        if let number = numberFormatter.number(from: bigPartTF.text ?? "0") {
            big = number.doubleValue
        }
        
        userDefaults.set(small, forKey: Constants.Part.small.key())
        userDefaults.set(big, forKey: Constants.Part.big.key())
        userDefaults.synchronize()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        [smallPartTF,bigPartTF].map {$0?.resignFirstResponder()}
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        [smallPartTF,bigPartTF].map { $0?.resignFirstResponder() }
        dismissAndSave()
        return true
    }
    
    @objc func keyboardWillShow() {
        scrollToView(-(header.frame.origin.y + header.frame.size.height),from: 0)
    }
    
    @objc func keyboardWillHide() {
        scrollToView(0, from: -(header.frame.origin.y + header.frame.size.height))
    }
    
    
    func scrollToView(_ offset:CGFloat,from:CGFloat){
        let animator = POPBasicAnimation(propertyNamed: kPOPLayerTranslationY)
        animator?.fromValue = from
        animator?.toValue = offset
        animator?.removedOnCompletion = true
        self.view.layer.pop_add(animator, forKey: "move2")
    }
    

}
