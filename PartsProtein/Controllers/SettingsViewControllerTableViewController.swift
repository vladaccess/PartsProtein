//
//  SettingsViewControllerTableViewController.swift
//  PartsProtein
//
//  Created by attom on 26.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import UIKit

class SettingsViewControllerTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.groupUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
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


}
