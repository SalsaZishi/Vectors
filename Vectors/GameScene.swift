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
        /* Setup your scene here */
        /*
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)
*/
        // create a test tile to see which code calls what color name and is redundant
        // initialize tile, default color is blank
        let test_tile = Tile(column: 0, row: 0)
        print("Description: \(test_tile.description)")
        print("Sprite Name: \(test_tile.spriteName)")
        
        // red tile
        let test_tile_color_enum = TileColor(rawValue: 1)
        print("Raw value: \(test_tile_color_enum?.description)")
        
        // add a gameboard to the screen
        let game_board = Gameboard(rows: 10, columns: 10, boardWidth: view.bounds.width, boardHeight: view.bounds.height)
        self.addChild(game_board)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
