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
    
    open lazy var realm: Realm = try! Realm()
    
    
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
    
    /**
     Create newEntry for date
    */
    func createEntryForDate(date:Date) -> Entry {
        let newEntry = Entry()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        newEntry.date = dateFormatter.string(from: date)
        try! realm.write {
            realm.add(newEntry, update: true)
        }
        return newEntry
    }
    
    func addPart(quantity:Double) {
        addPart(quantity, date: nil)
    }
    
    open func addPart(_ quantity:Double,date:Date?) {
        var entry:Entry?
        if let date = date {
            entry = entryForDate(date: date)
            if entry == nil {
                entry = createEntryForDate(date: date)
            }
        }else {
            entry = currentEntry()
        }
        try! realm.write {
            entry?.addPart(quantity, date: date, goal: userDefaults.double(forKey: Constants.Part.goal.key()))
        }
    }
    
    
    
    func currentPercentage() -> Double {
        return currentEntry().percentage
    }
    
    func removeLastPart() {
        let entry = currentEntry()
        if let lastPart = entry.parts.last {
            try! realm.write {
                entry.removeLastPart()
                realm.delete(lastPart)
            }
        }
    }
    
    func daysTracked() -> Int {
        return realm.objects(Entry.self).count
    }
    
    func overAllQuantity() -> Double {
        return realm.objects(Entry.self).sum(ofProperty: "quantity") as Double
    }
    
    
}
