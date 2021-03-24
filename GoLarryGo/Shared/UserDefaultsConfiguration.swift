//
//  UserDefaults.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 22/03/21.
//

import Foundation

class UserDefaultsConfiguration {
    
    static let sharedUserDefaultConfig = UserDefaultsConfiguration()
    static let defaults = UserDefaults.standard
    
    func setSoundToTrue() {
            UserDefaultsConfiguration.defaults.set(true, forKey: "sound")
            print(UserDefaultsConfiguration.defaults.bool(forKey: "sound"))
    }
    
    func setSoundToFalse() {
        UserDefaultsConfiguration.defaults.set(false, forKey: "sound")
    }
    
    func isSoundOn() -> Bool {
        return UserDefaultsConfiguration.defaults.bool(forKey: "sound")
    }
    
    func hasOnboarded(){
        // as a pattern the not specificated bool will return false
        let isFirstLaunch = UserDefaultsConfiguration.defaults.bool(forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore")

        if !isFirstLaunch {
            setSoundToTrue()
            print(UserDefaultsConfiguration.defaults.bool(forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore"))
             UserDefaultsConfiguration.defaults.set(true, forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore")
        }
    
}
    
}
