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
    
    
    /**
     Returns an entry for the given date
    */
    func entryForDate(date:Date) -> Entry? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let predicate:NSPredicate = NSPredicate(format: "date = %@", argumentArray: [dateFormatter.string(from: date)])
        let object = realm.objects(Entry.self).filter(predicate).first
        return object
    }
    
    
    /**
     Return current entry
    */
    func entryForToday() -> Entry? {
        return entryForDate(date: Date())
    }
    
    
    /**
     Return current entry if available else create new entry
    */
    func currentEntry() -> Entry {
        if let entry = entryForToday() {
            return entry
        }else {
            let newEntry = Entry()
            try! realm.write {
                realm.add(newEntry, update: true)
            }
            return newEntry
        }
    }
    
}
