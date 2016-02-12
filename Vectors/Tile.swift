//
//  Tile.swift
//  Vectors
//
//  Created by Zishi Wu on 2/11/16.
//  Copyright © 2016 Zishi Wu. All rights reserved.
//
import SpriteKit

// brush enum identification: red (rawValue = 0) or blue (rawValue = 1)
enum BrushColor: Int {
    case Red = 1, Blue
}

// tile color identification: blank(grey) = 0, red = 1, blue = 2
enum TileColor: Int, CustomStringConvertible {
    case Blank = 0, Red, Blue
    
    var spriteName: String {
        switch self {
        case .Blank:
            return "blank"
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

class Tile: CustomStringConvertible {

    // Properties of a tile: column, row, color, sprite
    var column: Int
    var row: Int
    var color: TileColor
    var sprite: SKSpriteNode?
    
    // returns name of sprite file to represent this tile
    var spriteName: String {
        return "\(color)_tile"
    }
    
    // return description of tile: column, row, color
    var description: String {
        return "\(column), \(row), \(color)"
    }
    
    // initialize tile, default color is blank
    init(column:Int, row:Int) {
        self.column = column
        self.row = row
        self.color = .Blank
        self.sprite = SKSpriteNode(imageNamed: "\(spriteName)")
    }
    
    // another way to initialize with CG coordinates
    // do we need this self.sprite?.name variable on intialization? I think we already have spriteName
    convenience init(column: Int, row: Int, spritePosition: CGPoint, spriteSize: CGSize, spriteName: String) {
        self.init(column: column, row: row)
        self.sprite?.position = spritePosition
        self.sprite?.size = spriteSize
        self.sprite?.name = spriteName
    }
    
    // changes tile color according to brushColor enum (0 = red, 1 = blue)
    // Note brush color red = 0 but tileColor red = 1. Should we change this to them being the same?
    func changeTileColor(brush_color: BrushColor.RawValue) {
        if (brush_color == 1) {
            self.color = .Red
        } else {
            self.color = .Blue
        }
        self.sprite?.texture = SKTexture(imageNamed: "\(spriteName)")
    }

}

