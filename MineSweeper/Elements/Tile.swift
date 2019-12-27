//
//  Pile.swift
//  MineSweeper
//
//  Created by Pasha Suprun on 26.12.2019.
//  Copyright © 2019 Pasha Suprun. All rights reserved.
//

import Foundation
import SpriteKit

class Tile: Equatable{
    
    unowned var board: Board// - declare class Board
    
    var x: Int
    var y: Int
    var isMine: Bool = false
    var isRevealed: Bool = false
    var isFlagged: Bool = false
    var numOfMinesAround: Int = 0
    
    var sprite: SKNode!
    
    init(board: Board, x:Int, y:Int){
        self.board = board
        self.x = x
        self.y = y
    }
    
    func setMine() -> Void{
        if(!isMine){
            isMine = true
            
            let neighbours = board.getNeighbours(self)
            for n in neighbours{
                n.numOfMinesAround += 1
            }
        }
    }
    
    func squareDistFromTile(_ tile:Tile) -> Int {
        return (x - tile.x)*(x - tile.x) + (y - tile.y)*(y - tile.y)
    }
    
    static func ==(t1: Tile, t2: Tile) -> Bool{
        return t1.x == t2.x && t1.y == t2.y
    }
    
}
