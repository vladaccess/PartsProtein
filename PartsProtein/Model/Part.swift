//
//  Part.swift
//  PartsProtein
//
//  Created by attom on 25.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import RealmSwift
//Part of food

class Part:Object {
    @objc dynamic var date = Date()
    @objc dynamic var quantity = 0.0
    public convenience init(quantity:Double) {
        self.init()
        self.quantity = quantity
    }
    
}



