//
//  PreferenceTool.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum AppMode: String {
    case WorkingMode = "WorkingMode"
    case NightMode = "NightMode"
}

class PreferenceTool {
    
    static let coinKey = "coin"
    
    static func switchMode(ofName mode: AppMode) {
        UserDefaults.standard.set(!isMode(ofName: mode), forKey: mode.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func isMode(ofName mode: AppMode) -> Bool {
        guard let modeActivated = UserDefaults.standard.object(forKey: mode.rawValue) as? Bool else {
            UserDefaults.standard.set(false, forKey: mode.rawValue)
            return false
        }
        return modeActivated
    }
    
    static func getCoinNumber() -> Int {
        return UserDefaults.standard.integer(forKey: coinKey)
    }
    
    static func addCoins(addNumber: Int) {
        UserDefaults.standard.set(getCoinNumber() + addNumber, forKey: coinKey)
    }
    
    static func deductCoins(deductNumber: Int) -> Bool {
        if getCoinNumber() - deductNumber >= 0 {
            UserDefaults.standard.set(getCoinNumber() - deductNumber, forKey: coinKey)
            return true
        } else {
            return false
        }
    }
    
}
