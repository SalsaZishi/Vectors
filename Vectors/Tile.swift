//
//  Tile.swift
//  Vectors
//
//  Created by Zishi Wu on 2/11/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//
import SpriteKit

enum TileColor: Int, CustomStringConvertible {
    
    // enum identification: white = 0, red = 1, blue = 2
    case White = 0, Red, Blue

    var spriteName: String {
        switch self {
        case .White:
            return "white"
        case .Red:
            return "red"
        case .Blue:
            return "blue"
        }
    }
    // return tile color
    var description: String {
        return self.spriteName
    }
}

// by default, tile color is white
class Tile: CustomStringConvertible {
    static let NUM_DIRECTIONS = 4
    
    // Properties of a tile
    var column: Int
    var row: Int
    
    var sprite: SKSpriteNode?
    
    // shortens retrieval of name from tile.description.spriteName to tile.spriteName
    // is this line of code necessary?
    var spriteName: String {
        return "blank tile"
    }
    
    // return description of tile: column, row, color
    var description: String {
        return "\(column), \(row), \(self.spriteName)"
    }
    
    var descriptionWithType: String {
        return "blank tile: [" + description + "]"
    }
    
    // initialize tile, default direction is Right = 0 and cannot rotate
    init(column:Int, row:Int) {
        self.column = column
        self.row = row
        
        self.sprite = SKSpriteNode(imageNamed: "blank_tile")
    }
    
    convenience init(column: Int, row: Int, spritePosition: CGPoint, spriteSize: CGSize, spriteName: String) {
        self.init(column: column, row: row)
        self.sprite?.position = spritePosition
        self.sprite?.size = spriteSize
        self.sprite?.name = spriteName
    }

}

