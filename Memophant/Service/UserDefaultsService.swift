//
//  UserDefaultsService.swift
//  Memophant
//
//  Created by Jan on 17.09.21.
//

import Foundation

class UserDefaultsService {
    
    static let isFirstAppStartUserDefaultsKey = "firstAppStart"

    static func checkOrSetFirstAppStart() -> Bool {
        let firstAppStart = UserDefaults.standard.object(forKey: isFirstAppStartUserDefaultsKey)
       
        if (firstAppStart == nil) {
            UserDefaults.standard.set(false, forKey: isFirstAppStartUserDefaultsKey)
            return true
        }
        
        return false
    }
    
}
