//
//  SettingsViewControllerTableViewController.swift
//  PartsProtein
//
//  Created by attom on 26.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import AHKActionSheet

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
                return 1
            }
        }else if section == 2 {
            return 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var actionSheet:AHKActionSheet?
        if (indexPath as NSIndexPath).section == 1 && (indexPath as NSIndexPath).row == 1 {
            actionSheet = AHKActionSheet(title: "From:")
            for unit in 5...22 {
                actionSheet?.addButton(withTitle: "\(unit):00", type: .default, handler: { _ in
                    self.updateNotificationSettings(for: Constants.Notification.from.key(), unit)
                })
            }
        }
        if (indexPath as NSIndexPath).section == 1 && (indexPath as NSIndexPath).row == 2 {
            actionSheet = AHKActionSheet(title: "To:")
            let upper = userDefaults.integer(forKey: Constants.Notification.from.key()) + 1
            for unit in upper...24 {
                actionSheet?.addButton(withTitle: "\(unit):00", type: .default, handler: { _ in
                    self.updateNotificationSettings(for: Constants.Notification.to.key(), unit)
                })
            }
        }
        if (indexPath as NSIndexPath).section == 1 && (indexPath as NSIndexPath).row == 3 {
            actionSheet = AHKActionSheet(title: "Interval:")
            for unit in 1...8 {
                let hour = (unit == 1) ? "hour" : "hours"
                actionSheet?.addButton(withTitle: "\(unit) \(hour)", type: .default, handler: { _ in
                    self.updateNotificationSettings(for: Constants.Notification.interval.key(), unit)
                })
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        actionSheet?.show()
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
        
        fromLabel.text = "\(String(describing: userDefaults.integer(forKey: Constants.Notification.from.key()))):00"
        toLabel.text = "\(String(describing: userDefaults.integer(forKey: Constants.Notification.to.key()))):00"
        everyLabel.text = "\(String(describing: userDefaults.integer(forKey: Constants.Notification.interval.key()))) hours"
    }
    
    func updateNotificationPreferences() {
        if notificationSwitch.isOn {
            NotificationHelper.unschoeduleNotification()
            NotificationHelper.registerNotification()
        }else {
            NotificationHelper.unschoeduleNotification()
        }
    }
    
    
    func updateNotificationSettings(for key:String,_ value:Int){
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
        updateUI()
        updateNotificationPreferences()
    }
}


