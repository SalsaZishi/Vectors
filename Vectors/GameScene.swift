//
//  GameScene.swift
//  Vectors
//
//  Created by Zishi Wu on 2/11/16.
//  Copyright (c) 2016 Zishi Wu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        self.size = view.bounds.size
        
        // create a test tile to see which code calls what color name and is redundant
        // initialize tile, default color is blank
        let test_tile = Tile(column: 0, row: 0)
        print("Description: \(test_tile.description)")
        print("Sprite Name: \(test_tile.spriteName)")
        
        // red tile
        let test_tile_color_enum = TileColor(rawValue: 1)
        print("Raw value: \(test_tile_color_enum?.description)")
        
        // add a gameboard to the screen
        let game_board = Gameboard(rows: 7, columns: 7, boardWidth: self.size.width, boardHeight: self.size.height)
        // add sprites to scene
        for tiles in game_board.tiles {
            for tile in tiles {
                print(tile.description)
                self.addChild(tile.sprite!)
            }
        }
        
        // change color of gameboard row to red (raw value = 1) as test
        game_board.changeRowColor(3, color: 1)
        
        // change color of gameboard column to blue (raw value = 2) as test
        game_board.changeColumnColor(4, color: 2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
