//
//  EntryHandler.swift
//  PartsProtein
//
//  Created by attom on 28.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import RealmSwift
/**
 Helper helps to perform operations on Realm
 */
final class EntryHandler:NSObject {
    static let shared = EntryHandler()

    lazy var userDefaults = UserDefaults.groupUserDefaults()
    
    lazy var realm:Realm = {
        guard let directory:URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.\(Constants.bundle())") else {
            fatalError("Unable to setup Realm. Make sure to setup your app group in the developer portal")
        }
        let path = directory.appendingPathComponent("db.realm")
        var config = Realm.Configuration()
        config.fileURL = path
        Realm.Configuration.defaultConfiguration = config
        return try! Realm()
    }()
    
}
