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
        }
    }
    
    
    class func unschoeduleNotification() {
        UIApplication.shared.unregisterForRemoteNotifications()
    }
    
    class func registerNotification() {
        let userDefautls = UserDefaults.groupUserDefaults()
        let startHour = userDefautls.integer(forKey: Constants.Notification.from.key())
        let endHour = userDefautls.integer(forKey: Constants.Notification.to.key())
        let interval = userDefautls.integer(forKey: Constants.Notification.interval.key())
        var hour = startHour
        
        while hour <= endHour {
            let content = UNMutableNotificationContent()
            content.title = "The title"
            content.body = "The body"
            content.sound = UNNotificationSound.default()
            
            var date = DateComponents()
            date.hour = hour
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let ident = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: ident, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                if error != nil {
                    print("Couldn't add request to system - \(error?.localizedDescription)")
                }
            })
            
            hour += interval
        }
    }
}
