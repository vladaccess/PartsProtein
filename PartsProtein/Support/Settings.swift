//
//  Settings.swift
//  PartsProtein
//
//  Created by attom on 21.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation

class Settings {
    
    class func registerDefaults() {
        let userDefaults = UserDefaults.groupUserDefaults()
        if !userDefaults.bool(forKey: "DEFAULTS_INTALLED") {
            userDefaults.set(true, forKey: "DEFAULTS_INTALLED")
            userDefaults.set(false, forKey: Constants.Health.on.key())
            userDefaults.set(true, forKey: Constants.Notification.on.key())
            userDefaults.set(10, forKey: Constants.Notification.from.key())
            userDefaults.set(22, forKey: Constants.Notification.to.key())
            userDefaults.set(2, forKey: Constants.Notification.interval.key())
            userDefaults.set(80, forKey: Constants.Part.weight.key())
        }
    }
    
    class func registerDefaultsForGramm() {
        let userDefaults = UserDefaults.groupUserDefaults()
        userDefaults.set(10, forKey: Constants.Part.small.key())
        userDefaults.set(30, forKey: Constants.Part.big.key())
        userDefaults.set(160, forKey: Constants.Part.goal.key())
    }
}

