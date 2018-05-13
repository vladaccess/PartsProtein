//
//  Entry.swift
//  PartsProtein
//
//  Created by attom on 27.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import RealmSwift
/**
 Sum of portion of entire day
 */
class Entry:Object {
    @objc dynamic var date = Entry.defaultDate()
    @objc dynamic var percentage:Double = 0.0
    @objc dynamic var quantity:Double = 0.0
    @objc dynamic var goal:Double = 0.0
    open var parts = List<Part>()
    
    
    /**
     Transform the current Date to String
    */
    class func defaultDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    override open class func primaryKey()->String {
        return "date"
    }
    /**
     Adds a portion of protein to the current day
     - parameter quantity: The portion size
     - parameter goal: The daily goal
     - parameter date: The date of the portion
     */
    func addPart(_ quantity:Double,date:Date?,goal:Double) {
        let part = Part(quantity: quantity)
        parts.append(part)
        self.quantity += quantity
        self.goal = goal
        if let date = date {
            part.date = date
        }
        if goal > 0 {
            percentage = (self.quantity/self.goal) * 100
        }
    }
    
    /**
     Remove the lastest portion of protein
    */
    func removeLastPart() {
        if let latestPart = self.parts.last {
            self.quantity -= latestPart.quantity
            if goal > 0 {
                self.percentage = (self.quantity/self.goal) * 100
            }
            if self.percentage < 0 {
                self.percentage = 0
            }
            self.parts.removeLast()
        }
        
    }
    /**
     Turn the percentage into String
    */
    func formattedPercentage() -> String {
        return percentage.formattedPercentage()
    }
}
