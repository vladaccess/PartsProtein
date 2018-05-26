//
//  SettingsViewControllerTableViewController.swift
//  PartsProtein
//
//  Created by attom on 26.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit

class SettingsViewControllerTableViewController: UITableViewController,UITextFieldDelegate {
    
    let userDefaults = UserDefaults.groupUserDefaults()
    
    
    @IBOutlet weak var notificationSwitch:UISwitch!
    @IBOutlet weak var healthSwitch:UISwitch!
    @IBOutlet weak var smallPortionTF:UITextField!
    @IBOutlet weak var bigPortionTF:UITextField!
    @IBOutlet weak var goalTF:UITextField!
    @IBOutlet weak var fromLabel:UILabel!
    @IBOutlet weak var toLabel:UILabel!
    @IBOutlet weak var everyLabel:UILabel!
    
    
    
    var numberFormatter:NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        [smallPortionTF,bigPortionTF,goalTF].map {
            textF in
            textF?.inputAccessoryView = Global.numericToolBar(textF, selector: #selector(UIResponder.resignFirstResponder), barColor: Tint.mainTint, tintColor: .white)
        }
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            if userDefaults.bool(forKey: Constants.Notification.on.key()) {
                return 4
            }else {
                1
            }
        }else if section == 2 {
            return 1
        }
        return 1
    }
    
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == smallPortionTF {
            storeValue(smallPortionTF, to: Constants.Part.small.key())
        }
        if textField == bigPortionTF {
            storeValue(bigPortionTF, to: Constants.Part.big.key())
        }
        if textField == goalTF {
            storeValue(goalTF, to: Constants.Part.goal.key())
        }
    }
    
    func storeValue(_ textField:UITextField,to key:String) {
        guard let text = textField.text else { return }
        
        let numberText = numberFormatter.number(from: text) as? Double ?? 0.0
    
        userDefaults.set(numberText, forKey: key)
        userDefaults.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        smallPortionTF.text = userDefaults.string(forKey: Constants.Part.small.key())
        bigPortionTF.text = userDefaults.string(forKey: Constants.Part.big.key())
        goalTF.text = userDefaults.string(forKey: Constants.Part.goal.key())
        
        notificationSwitch.isOn = userDefaults.bool(forKey: Constants.Notification.on.key())
        healthSwitch.isOn = userDefaults.bool(forKey: Constants.Health.on.key())
    }


}
