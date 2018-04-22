//
//  Settings.swift
//  PartsProtein
//
//  Created by attom on 21.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation

class Settings {
    class func registerDefaultsForGramm() {
        let userDefaults = UserDefaults.groupUserDefaults()
        userDefaults.set(20, forKey: Constants.Part.small.key())
        userDefaults.set(40, forKey: Constants.Part.big.key())
    }
}

