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


extension Double {
    func formattedPercentage() -> String {
        let value = self.rounded()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter.string(for: value/100) ?? "\(value)%"
    }
}
