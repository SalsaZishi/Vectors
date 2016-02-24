//
//  LevelLoader.swift
//  Vectors
//
//  Created by Zishi Wu on 2/18/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//
import Foundation
/*
Reads a .lvl file line by line, where each line is a row of the gameboard.
Encoding for .lvl file is done using the constants in the class to determine which type of tile to
load. We specify direction in the level file as follows: encodedTileDirections.Up.enumString<R>,where
EncodedTileDirections.Up.enumString is any of the possible string representations of the encodedTileDirections enum,
and <R> is any tile which is a rotatable tile (or a subclass of rotatable tile)
*/

class LevelLoader {
    // encoding characters for the type of tile
    static let DEFAULT_TILE = "D"
    static let RED_TILE = "R"
    static let BLUE_TILE = "B"
    static let LEVEL_EXTENSION = ".lvl"
    
    var gameboard: GameBoard!
    let mainBundle: NSBundle
    var gameScene: GameScene
    
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        self.gameboard = nil
        self.mainBundle = NSBundle.mainBundle()
    }
    
    func loadLevel(levelName: String) -> GameBoard {
        
        // stream reader reads level file into an array
        let filePath = self.mainBundle.pathForResource("/levels/" + levelName, ofType: LevelLoader.LEVEL_EXTENSION)
        var lines = [String]()
        
        if let streamReader = StreamReader(path: filePath!) {
            defer {
                streamReader.close()
            }
            
            // put the lines in our array so we can create the gameboard of appropriate size
            for line in streamReader {
                lines.append(String(line))
            }
        }
        
        let numRows = lines[0].characters.count
        self.gameboard = GameBoard(rows: numRows, columns: lines.count, boardWidth: self.gameScene.size.width, boardHeight: self.gameScene.size.height)
        
        var currColumn = 0
        for line in lines {
            var currRow = 0
            for char in line.characters {
                // let currentTile = self.gameboard.tiles[currColumn][currRow]
                // let currentTileSprite = currentTile.sprite!
                // let spriteName = String(currColumn) + ", " + String(currRow)
                
                // make sure we init the new tile with the posizion and size of the old tile
                switch String(char) {
                    
                case LevelLoader.DEFAULT_TILE:
                    break
                case LevelLoader.RED_TILE:
                    /*
                    self.gameboard.tiles[currColumn][currRow] = Tile(column: currColumn, row: currRow, spritePosition: currentTileSprite.position, spriteSize: currentTileSprite.size, spriteName: spriteName)
                    */
                    self.gameboard.tiles[currColumn][currRow].changeColor(1)
                    break
                case LevelLoader.BLUE_TILE:
                    self.gameboard.tiles[currColumn][currRow].changeColor(2)
                    break
                default:
                    break // throw and/or print an error here
                }
                currRow++
            }
            currColumn++
        }
        
        return self.gameboard
    }
}
