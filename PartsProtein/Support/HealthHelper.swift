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
    let userDefaults = UserDefaults.groupUserDefaults()
    
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
    
    @available (iOS 9.0,*)
    func saveSample(_ value:Double,date:Date? = nil) {
        if !userDefaults.bool(forKey: Constants.Health.on.key()) {
            return
        }
        if !HKHealthStore.isHealthDataAvailable() || store.authorizationStatus(for: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!) != HKAuthorizationStatus.sharingAuthorized {
            return
        }
        
        guard let type = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein) else { return }
        
        let quantity = HKQuantity(unit: HKUnit.gram(), doubleValue: value)
        
        let object = HKQuantitySample(type: type, quantity: quantity, start: date ?? Date(), end: date ?? Date())
        
        store.save(object, withCompletion: { (success, error) in
            if let error = error {
                print("Couldn't save object to Health - \(error)")
            }
        })
        
    }
}
