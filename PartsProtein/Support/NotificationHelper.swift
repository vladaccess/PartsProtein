//
//  NotificationHelper.swift
//  PartsProtein
//
//  Created by attom on 24.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class NotificationHelper {
    class func askPermission() {
        let center = UNUserNotificationCenter.current()
        let options:UNAuthorizationOptions = [.alert,.badge,.sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print("Couldn't perform the autorization - \(error.localizedDescription)")
                return
            }
            
            if granted {
                UIApplication.shared.registerForRemoteNotifications()
                print("Register did successfully")
            }
        }
    }
}
