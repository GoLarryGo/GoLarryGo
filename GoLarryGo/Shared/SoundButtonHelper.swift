//
//  SoundButtonHelper.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 23/03/21.
//

import Foundation
import UIKit

class SoundButtonHelper {
    static let sharedSoundButtonState = SoundButtonHelper()
    
    func setButtonImage(button: UIButton) {
        if UserDefaultsConfiguration.sharedUserDefaultConfig.isSoundOn() {
            button.setImage(UIImage(named: "sound on"), for: .normal)
        } else {
            button.setImage(UIImage(named: "sound off"), for: .normal)
        }
  
    }
    
    func changeSoundButtonState() {
        if UserDefaultsConfiguration.sharedUserDefaultConfig.isSoundOn() {
            UserDefaultsConfiguration.sharedUserDefaultConfig.setSoundToFalse()
        } else {
            UserDefaultsConfiguration.sharedUserDefaultConfig.setSoundToTrue()

        }
    }

}
