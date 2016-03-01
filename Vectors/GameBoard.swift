//
//  GameBoard.swift
//  Vectors
//
//  Created by Zishi Wu on 2/11/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//
import Foundation
import SpriteKit

enum Direction {
    case UP, DOWN, LEFT, RIGHT
}

struct DiagonalDirection {
    let xDirection: Direction
    let yDirection: Direction
}

class GameBoard {
    
    var tiles: [[Tile]] = [[Tile]]()
    var boardWidthByColumns: Int
    var boardHeightByRows: Int
    var boardHeight: CGFloat
    var boardWidth: CGFloat
    var currentBoard: [[Tile]] = [[Tile]]()
    
    init(rows: Int, columns: Int, boardWidth: CGFloat, boardHeight: CGFloat) {
        self.boardWidthByColumns = 0
        self.boardHeightByRows = 0

        let board_scene_ratio = 0.75
        
        // Bottom (y = 0) so put board start at top
        print("Board Height: \(boardHeight)")
        
        // Left (x = 0) so put board start at left
        print("Board Width: \(boardWidth)")
        
        // make gameboard square
        let boardDimension: CGFloat
        if (boardWidth < boardHeight) {
            boardDimension = boardWidth
        } else {
            boardDimension = boardHeight
        }
        self.boardHeight = boardDimension * CGFloat(board_scene_ratio)
        self.boardWidth = self.boardHeight
        
        // Adjust tileSprite size to create board that fits frame based on ratio and depending on number of tiles
        let spriteHeight = CGFloat(board_scene_ratio) * boardDimension / CGFloat(rows)
        let spriteWidth = CGFloat(board_scene_ratio) * boardDimension / CGFloat(columns)
        print("Space Height: \(spriteHeight)")
        print("Space Width: \(spriteWidth)")
        
        // Bottom left corner of frame is 0,0 and top right corner of frame is boardWidth, boardHeight
        let xStart: CGFloat = (boardWidth - spriteWidth * CGFloat(columns) + spriteWidth) / 2.0
        let yStart: CGFloat = (boardHeight + spriteHeight * CGFloat(rows) - spriteHeight) / 2.0
            
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
            self.boardWidthByColumns++
        }
        
        // we assume equal size
        self.boardHeightByRows = self.boardWidthByColumns
    }
    
    func replaceTileAt(row: Int, column: Int, withTile tile:Tile) {
        self.tiles[column][row] = tile
    }
    
    // get tile from grid with row and column specified
    func tileFromName(tileName: String?) -> Tile? {
        if let name = tileName {
            // no way to access character at index in swift see: https://www.reddit.com/r/swift/comments/2bvrh9/getting_a_specific_character_in_a_string/
            let colIndex = name.startIndex.advancedBy(0)
            let rowIndex = name.startIndex.advancedBy(3)
            let row = Int(String(name[rowIndex]))!
            let column = Int(String(name[colIndex]))!
            
            return tiles[column][row]
        }
        // no tile
        return nil
    }
    
    // change row color
    func changeRowColor(row: Int, color:TileColor.RawValue) {
        for (var i = 0; i < tiles[row].count; i++) {
            tiles[row][i].changeColor(color)
        }
    }
    
    // change column color
    func changeColumnColor(column: Int, color:TileColor.RawValue) {
        for (var i = 0; i < tiles[column].count; i++) {
            tiles[i][column].changeColor(color)
        }
    }
    
    func changeDiagonalColor(direction: DiagonalDirection, includingTile tile: Tile, withColor color: TileColor.RawValue) {
        var x = tile.column, y = tile.row
        
        if direction.xDirection == .RIGHT {
            // right and up
            if direction.yDirection == .UP {
                while x >= 0 && y < boardWidthByColumns  {
                    tiles[x][y].changeColor(color)
                    x--
                    y++
                }
                // reset
                x = tile.column
                y = tile.row
                
                while x < boardHeightByRows && y >= 0 {
                    tiles[x][y].changeColor(color)
                    x++
                    y--
                }
            // right and down
            } else {
                while x < boardHeightByRows && y < boardWidthByColumns {
                    tiles[x][y].changeColor(color)
                    x++
                    y++
                }
                // reset
                x = tile.column
                y = tile.row
                
                while x >= 0 && y >= 0 {
                    tiles[x][y].changeColor(color)
                    x--
                    y--
                }
            }
        } else {
            // left and up
            if direction.yDirection == .UP {
                while x >= 0 && y >= 0 {
                    tiles[x][y].changeColor(color)
                    x--
                    y--
                }
                // reset
                x = tile.column
                y = tile.row
                
                while x < boardHeightByRows && y < boardWidthByColumns {
                    tiles[x][y].changeColor(color)
                    x++
                    y++
                }
            // left and down
            } else {
                while x < boardHeightByRows && y >= 0 {
                    tiles[x][y].changeColor(color)
                    x++
                    y--
                }
                // reset
                x = tile.column
                y = tile.row
                
                while x >= 0 && y < boardWidthByColumns {
                    tiles[x][y].changeColor(color)
                    x--
                    y++
                }
            }
        }
    }
    
    func saveCurrentBoard() {
        
        NSUserDefaults.standardUserDefaults().setObject(tiles, forKey: "current_board")
 
        // store array of current game board into currentBoard this is loading not saving
        currentBoard = NSUserDefaults.standardUserDefaults().objectForKey("current_board")! as! [[Tile]]
    }
    
    // Alfredo write func to test the save current board func
    func loadCurrentBoard() {
        
    }
}