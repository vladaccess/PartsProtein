//
//  Extensions.swift
//  PartsProtein
//
//  Created by attom on 21.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation

extension UserDefaults {
    class func groupUserDefaults() -> UserDefaults {
        return UserDefaults(suiteName: "group.\(Constants.bundle())")!
    }
}
