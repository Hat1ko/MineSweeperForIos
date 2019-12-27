//
//  Settings.swift
//  MineSweeper
//
//  Created by Pasha Suprun on 27.12.2019.
//  Copyright © 2019 Pasha Suprun. All rights reserved.
//

import Foundation

class Settings{
    fileprivate let difficultyString: String = "difficulty"
    fileprivate let vibrationString: String = "vibrationEnabled"// true if is

//    fileprivate let vibrationEnabledString: String = "vibrationEnabled"
    
    fileprivate let flagWithLongPressEnabledString: String = "flagWithLongPressEnabled"// true if is

//    fileprivate let flagWitghLongPressDisabledString: String = "flagWithLongPressDisabled"
    
    fileprivate let bottomBarHiddenString: String = "botomBarHiddenString"//true if is
    fileprivate let completeVersionString: String = "completeVersion"
    
    fileprivate let userDefaults: UserDefaults = UserDefaults.standard
    
    static let settingsInstance: Settings = Settings()
    
    //return GameDifficulty
    var difficulty: GameDifficulty {
        get {
            if let difficulty = userDefaults
                .string(forKey: difficultyString)
                .flatMap({ GameDifficulty(rawValue: $0)}){
                return difficulty
            }
            else {
                return .Easy
            }
        }
    }
    
    //toEnableVibreatons?
    var vibrations: Bool {
        get{
            return userDefaults.bool(forKey: vibrationString)
        }
        set{
            userDefaults.set(newValue, forKey: vibrationString)
        }
    }
    
    //toFlagWithLongPress?
    var flagWithLongPress: Bool {
        get{
            return userDefaults.bool(forKey: flagWithLongPressEnabledString)
        }
        set{
            userDefaults.set(newValue, forKey: flagWithLongPressEnabledString)
        }
    }
    
    //isBottomBarHidden?
    var bottomHidden: Bool {
        get{
            return userDefaults.bool(forKey: bottomBarHiddenString)
        }
        set{
            userDefaults.set(newValue, forKey: bottomBarHiddenString)
        }
    }
    
}
