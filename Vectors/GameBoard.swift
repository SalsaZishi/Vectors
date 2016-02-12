//
//  GameBoard.swift
//  Vectors
//
//  Created by Zishi Wu on 2/11/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//
import Foundation
import SpriteKit

// Need to make tiles into squares
class Gameboard {
    
    // array that holds all the tiles
    var tiles: [[Tile]] = [[Tile]]()
    
    init(rows: Int, columns: Int, boardWidth: CGFloat, boardHeight: CGFloat) {
        
        let board_scene_ratio = 0.75
        
        // Bottom (y = 0) so put board start at top
        print("Board Height: \(boardHeight)")
        
        // Left (x = 0) so put board start at left
        print("Board Width: \(boardWidth)")
        
        // we want each tile to be a square with equal width and height
        // If board height and width are not equal, choose the smaller value of the two
        // and set both equal to the smaller value
        var boardDimension: CGFloat
        if (boardWidth < boardHeight) {
            boardDimension = boardWidth
        } else {
            boardDimension = boardHeight
        }
        
        // Adjust tileSprite size to fit into 75% of the board depending on number of tiles
        let spriteHeight = CGFloat(board_scene_ratio) * boardDimension / CGFloat(columns)
        let spriteWidth = CGFloat(board_scene_ratio) * boardDimension / CGFloat(rows)
        print("Space Height: \(spriteHeight)")
        print("Space Width: \(spriteWidth)")
        
        // initialize coordinates for center of each tile in board in CGFloat type
        // coordinates for center of each tile in double to be converted to CGFloat
        // 0, 0 is bottom left so x = 0, y = boardHeight = top left
        // increment x a little to the right: spriteWidth / 2.0 = center of leftmost tile
        // and 0.25 / 2 = 12.5% of the tile (center of the left gap caused by the board taking up 75% of scene)
        let xStart: CGFloat = spriteWidth/CGFloat(2.0) + CGFloat((1.0 - board_scene_ratio)/2.0) * boardDimension
        let yStart: CGFloat = boardDimension - spriteHeight/CGFloat(2.0) - CGFloat((1.0 - board_scene_ratio)/2.0) * boardDimension
        
        // declare xCoord and yCoord vars
        var xCoord: CGFloat = CGFloat(0.0)
        var yCoord: CGFloat = CGFloat(0.0)
        
        // set up tiles Array a.k.a. game board
        for var column = 0; column < columns; column++ {
            let tileRow = [Tile]()
            tiles.append(tileRow)
            
            // initialize or update value of yCoor
            // since we start at top of screen, to populate tiles downwards, decrement by spriteHeight
            if column == 0 {
                yCoord = CGFloat(yStart)
            } else {
                yCoord -= spriteHeight
            }
            
            for var row = 0; row < rows; row++ {
                // initialize or update value of xCoor
                // since we start at left of screen, to populate tiles to the right, increment by spriteWidth
                if row == 0 {
                    xCoord = CGFloat(xStart)
                } else {
                    // for some reason this spacing is bigger than the actual sprite image so it
                    // causes empty nil space between the tiles...
                    xCoord += spriteWidth
                }
                
                let position = CGPointMake(xCoord, yCoord)
                let size = CGSizeMake(spriteWidth, spriteHeight)
                // name = row, column to identify sprite at specific location
                let tileName = String(column) + ", " + String(row)
                
                // add a new tile to specific row, column
                let newTile = Tile(column: column, row: row, spritePosition: position, spriteSize: size, spriteName: tileName)
                tiles[column].append(newTile)
            }
        }
    }
    
    func replaceTileAt(row: Int, column: Int, withTile tile:Tile) {
        self.tiles[column][row] = tile
    }
    
    func tileFromName(tileName: String) -> Tile? {
        // no way to access character at index in swift see: https://www.reddit.com/r/swift/comments/2bvrh9/getting_a_specific_character_in_a_string/
        let colIndex = tileName.startIndex.advancedBy(0)
        let rowIndex = tileName.startIndex.advancedBy(3)
        let row = Int(String(tileName[rowIndex]))!
        let column = Int(String(tileName[colIndex]))!
        
        return tiles[column][row]
    }
}