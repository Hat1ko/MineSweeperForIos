//
//  GameDifficulty.swift
//  MineSweeper
//
//  Created by Pasha Suprun on 27.12.2019.
//  Copyright © 2019 Pasha Suprun. All rights reserved.
//

import Foundation

enum GameDifficulty: String{
    case Easy = "Easy", Medium = "Medium", Hard = "Hard"

//    var rawValue: self.RawValue { get }
    
    var size: (width:Int, height: Int) {

        switch self{
        case .Easy:
            return (9, 9)
            
        case .Medium:
            return (9, 11)
            
        case .Hard:
            return (10, 14)
        }
    }
    
    var numOfMines: Int{
        switch self{
        case .Easy:
            return 9
        case .Medium:
            return 16
        case .Hard:
            return 25
        }
    }
    
    static var allValues: [GameDifficulty]{
        return [.Easy, .Medium, .Hard]
    }

    static var random: GameDifficulty{
        let rand = Int(arc4random_uniform(UInt32(allValues.count)))
        return allValues[rand]
    }
    
    static func fromInt(_ value: Int) -> GameDifficulty?{
        switch value{
        case 1:
            return .Easy
        case 2:
            return .Medium
        case 3:
            return .Hard
        default:
            return nil
        }
    }
    
    var toInt: Int{
        switch self{
            case .Easy:
                return 1
            case .Medium:
                return 2
            case .Hard:
                return 3
        }
    }
    
}
