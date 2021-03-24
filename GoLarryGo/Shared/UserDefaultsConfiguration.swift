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
    
        let isFirstLaunch = UserDefaultsConfiguration.defaults.bool(forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore")

        if isFirstLaunch {
//            defaults.set(true, forKey: "sound")
            print(UserDefaultsConfiguration.defaults.bool(forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore"))
        }
        
        else {
           setSoundToTrue()
           print(UserDefaultsConfiguration.defaults.bool(forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore"))
            UserDefaultsConfiguration.defaults.set(true, forKey: "com.patriciasampaiosiqueira.GoLarryGo.FirstLaunch.WasLaunchedBefore")
            
        }

}
    
}
