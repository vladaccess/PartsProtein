//
//  HealthHelper.swift
//  PartsProtein
//
//  Created by attom on 26.05.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation
import HealthKit

class HealthHelper {
    static let share = HealthHelper()
    
    private init() {}
    
    let store = HKHealthStore()
    
    
    @available (iOS 9.0,*)
    func askPermission() {
        if HKHealthStore.isHealthDataAvailable() {
            guard let type = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein) else { return }
            store.requestAuthorization(toShare: [type], read: nil, completion: { (success, error) in
                if let error = error {
                    print("Couldn't authorizate - \(error)")
                }
            })
            
        }
    }
}
