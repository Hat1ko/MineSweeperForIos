//
//  File.swift
//  MineSweeper
//
//  Created by Pasha Suprun on 27.12.2019.
//  Copyright © 2019 Pasha Suprun. All rights reserved.
//

import Foundation

class GameCounter {
    fileprivate let gameWonString: String = "won"
    fileprivate let gameLostString: String = "lost"
    fileprivate let gameStartedString: String = "started"
    
    fileprivate let userDefaults: UserDefaults = UserDefaults.standard
    
    static let sharedInstance: GameCounter = GameCounter()
    
    var numberOfGamesWon: Int {
        var num: Int = 0
        for diff in GameDifficulty.allValues {
            num += getNumberOfGamesWon(diff)
        }
        return num
    }

    var numberOfGamesLost: Int {
        var num: Int = 0
        for diff in GameDifficulty.allValues {
            num += getNumberOfGamesLost(diff)
        }
        return num
    }
    
    var numberOfGamesStart: Int {
        var num: Int = 0
        for diff in GameDifficulty.allValues {
            num += getNumberOfGamesStarted(diff)
        }
        return num
    }
    
    //per difficulty
    func getNumberOfGamesWon(_ diff: GameDifficulty) -> Int {
        return userDefaults.integer(forKey: diff.rawValue + gameWonString)
    }
    
    //per difficulty
    func getNumberOfGamesLost(_ diff: GameDifficulty) -> Int {
        return userDefaults.integer(forKey: diff.rawValue + gameLostString)
    }
    
    //per difficulty
    func getNumberOfGamesStarted(_ diff: GameDifficulty) -> Int {
        return userDefaults.integer(forKey: diff.rawValue + gameStartedString)
    }
    
    func resetAllStats() -> Void {
        for diff in GameDifficulty.allValues {
            userDefaults.set(0, forKey: diff.rawValue + gameWonString)
            userDefaults.set(0, forKey: diff.rawValue + gameLostString)
            userDefaults.set(0, forKey: diff.rawValue + gameStartedString)
        }
    }
}
