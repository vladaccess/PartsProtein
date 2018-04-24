//
//  NotificationViewController.swift
//  PartsProtein
//
//  Created by attom on 24.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit
import AHKActionSheet

class NotificationViewController: OverboardViewController {
    
    @IBOutlet weak var notificationSwitch:UISwitch!
    @IBOutlet weak var fromLabel:UILabel!
    @IBOutlet weak var toLabel:UILabel!
    @IBOutlet weak var intervalLabel:UILabel!
    
    
    
    let userDefaults = UserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func updateUI() {
        fromLabel.text = "\(userDefaults.integer(forKey: Constants.Notification.from.key())):00"
        toLabel.text = "\(userDefaults.integer(forKey: Constants.Notification.to.key())):00"
        notificationSwitch.isOn = userDefaults.bool(forKey: Constants.Notification.on.key())
        let hour = userDefaults.integer(forKey: Constants.Notification.interval.key()) > 1 ? "Hours" : "Hour"
        intervalLabel.text = "\(userDefaults.integer(forKey: Constants.Notification.interval.key())) \(hour)"
    }
    
    lazy var fromActionSheet:AHKActionSheet = {
        let actionSheet = AHKActionSheet(title: NSLocalizedString("From:", comment: ""))
        for index in 5...22 {
            actionSheet?.addButton(withTitle:"\(index):00", type: AHKActionSheetButtonType.default, handler: { _ in
                self.userDefaults.set(index, forKey: Constants.Notification.from.key())
                self.userDefaults.synchronize()
                self.updateUI()
            })
        }
        return actionSheet!
    }()
    
    lazy var intervalActionSheet:AHKActionSheet = {
        let actionSheet = AHKActionSheet(title: "Every:")
        for index in 1...8 {
            let hour = index > 1 ? "Hours" : "Hour"
            actionSheet?.addButton(withTitle: "\(index) \(hour)", type: AHKActionSheetButtonType.default, handler: { (action) in
                self.userDefaults.set(index, forKey: Constants.Notification.interval.key())
                self.userDefaults.synchronize()
                self.updateUI()
            })
        }
        return actionSheet!
    }()
    
    
    
    
    @IBAction func fromSelection(_ sender:UIButton) {
        fromActionSheet.show()
    }
    
    @IBAction func intervalSelection(_ sender:UIButton) {
        intervalActionSheet.show()
    }
    @IBAction func toSelection(_ sender:UIButton) {
        let actionSheet = AHKActionSheet(title: "To:")
        let upper = userDefaults.integer(forKey: Constants.Notification.from.key()) + 1
        for index in upper...24 {
            actionSheet?.addButton(withTitle: NSLocalizedString("\(index):00", comment: ""), type: AHKActionSheetButtonType.default, handler: { _ in
                self.userDefaults.set(index, forKey: Constants.Notification.to.key())
                self.userDefaults.synchronize()
                self.updateUI()
            })
        }
        actionSheet?.show()
    }
    
    @IBAction func onNotification(_ sender:UISwitch) {
        userDefaults.set(sender.isOn, forKey: Constants.Notification.on.key())
        userDefaults.synchronize()
    }
    
    @IBAction func done(_ sender:UIButton) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.loadMainInterface()
        }
    }
    


}
