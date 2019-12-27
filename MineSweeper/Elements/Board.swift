//
//  Board.swift
//  MineSweeper
//
//  Created by Pasha Suprun on 26.12.2019.
//  Copyright © 2019 Pasha Suprun. All rights reserved.
//

import Foundation

class Board{
    
    var gameDifficulty: GameDifficulty
    
    var minesInitialized: Bool
    var gameOver: Bool
    var startDate: Date?
    var score: TimeInterval?
    var tiles: [Tile]
    
    var width: Int {
        return gameDifficulty.size.width
    }
    
    var height: Int {
        return gameDifficulty.size.height
    }
    
    var numberOfMines: Int {
        return gameDifficulty.numOfMines
    }
    
    var isGameWon: Bool{
        for tile in tiles{
            if !tile.isFlagged && tile.isMine{ // check correctness
                return false
            }
        }
        return true
    }
    
    init(_ gameDifficulty: GameDifficulty){
        self.gameDifficulty = gameDifficulty
        minesInitialized = false
        gameOver = false
        startDate = nil
        score = nil
        
        tiles = [Tile]()
        
        assert(numberOfMines < width * height,
               "Number of mines cant be equal or bigger than total number if tiles within the game")
    }
    
    func initMines(_ playedTile: Tile?) -> Void{
        var possibilities = [Tile]()
        
        var protectedTiles = [Tile]()
        if let playedTile = playedTile{
            protectedTiles.append(contentsOf: getNeighbours(playedTile))
            protectedTiles.append(playedTile)
        }

        for tile in tiles{
            if protectedTiles.contains(tile){
                possibilities.append(tile)
            }
        }
        
        for _ in 0..<numberOfMines {
            let i = Int(arc4random_uniform(UInt32(possibilities.count)))
            possibilities[i].setMine()
            possibilities.remove(at: i)
        }
    }
    
    //if cords are within board
    func isInBoard(_ x:Int, _ y:Int) -> Bool{
        return x > -1 && y > -1 && x < self.width && y < self.height
    }
    
    func getTileIndex(_ x:Int, _ y:Int) -> Int{
        return y * width + x;
    }
    
    func getTile(_ x:Int, _ y:Int) -> Tile?{
        if isInBoard(x, y){
            return tiles[getTileIndex(x, y)]
        }
        return nil
    }
    
    func getNeighbours(_ tile:Tile) -> [Tile]{
        var neighbours = [Tile]()
        
        //cords for getting neigbours
        let xCords: [Int] = [-1, -1, -1, 0, 1, 1, 1, 0]
        let yCords: [Int] = [-1, 0, 1, 1, 1, 0, -1, -1]
        
        for i in 0...xCords.count {
            if let t = getTile(tile.x + xCords[i], tile.y + yCords[i]){
                neighbours.append(t)
            }
        }
        
        return neighbours
    }
    
    func flag(_ x:Int, _ y:Int) -> [Tile]{
        if let tile = getTile(x, y){
            return flag(tile)
        }
        return [Tile]()
    }
    
    func flag(_ tile:Tile) -> [Tile]{
        var flaggedTiles = [Tile]()
        
        guard self.minesInitialized else {return flaggedTiles}
        
        if !gameOver{
            if !tile.isRevealed {
                tile.isFlagged = !tile.isFlagged
                flaggedTiles.append(tile)
            }
            else{
                var numOfUnrevealed = 0
                let neighbours = getNeighbours(tile)
                for n in neighbours{
                    if !n.isRevealed{
                        numOfUnrevealed += 1
                    }
                }
                
                if numOfUnrevealed == tile.numOfMinesAround{
                    for n in neighbours{
                        if !n.isRevealed && !n.isFlagged {
                            let tiles = flag(n)
                            flaggedTiles += tiles
                        }
                    }
                }
            }
        }
        return flaggedTiles
    }
}
