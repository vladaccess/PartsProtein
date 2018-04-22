//
//  Constants.swift
//  PartsProtein
//
//  Created by attom on 21.04.2018.
//  Copyright © 2018 attom. All rights reserved.
//

import Foundation

public enum Constants {
    public static func bundle() -> String {
        return "C.PartsProtein"
    }
    
    public enum UnitOfMeasure:Int {
        case gramm
    }
    
    public enum General:Int {
        case unitOfMeasure,overboardingShown
        func key()->String {
            switch self {
            case .overboardingShown: return "OVERBARDING_SHOWN"
            case .unitOfMeasure: return "UNIT_OF_MEASURE"
            }
        }
    }
    
    
    public enum Part:Int {
        case small,big,goal,weight
        func key()->String {
            switch self {
            case .big: return "BIG_PART"
            case .small: return "SMALL_PART"
            case .goal: return "GOAL_PORTION"
            case .weight: return "WEIGHT"
            }
        }
    }
}
