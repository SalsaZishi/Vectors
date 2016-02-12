//
//  GameScene.swift
//  Vectors
//
//  Created by Zishi Wu on 2/11/16.
//  Copyright (c) 2016 Zishi Wu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var touchedTiles = [Tile]()
    var initialTouchedTile: Tile!
    var lastTouchedTile: Tile!
    var game_board: Gameboard!
    
    override func didMoveToView(view: SKView) {
        self.size = view.bounds.size
        
        // pan gesture recognizer
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPanOnTiles:")
        self.view?.addGestureRecognizer(gestureRecognizer)
        
        // create a test tile to see which code calls what color name and is redundant
        // initialize tile, default color is blank
        let test_tile = Tile(column: 0, row: 0)
        print("Description: \(test_tile.description)")
        print("Sprite Name: \(test_tile.spriteName)")
        
        // red tile
        let test_tile_color_enum = TileColor(rawValue: 1)
        print("Raw value: \(test_tile_color_enum?.description)")
        
        // add a gameboard to the screen
        game_board = Gameboard(rows: 7, columns: 7, boardWidth: self.size.width, boardHeight: self.size.height)
        // add sprites to scene
        for tiles in game_board.tiles {
            for tile in tiles {
                print(tile.description)
                self.addChild(tile.sprite!)
            }
        }
        // initialize enum representing brush color with value 0 = red
        var brush_color = BrushColor(rawValue: 0)
        
        // change color of gameboard row to red (raw value = 1) as test
        //game_board.changeRowColor(0, color: 1)
        
        // change color of gameboard column to blue (raw value = 2) as test
        //game_board.changeColumnColor(0, color: 2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // handle pan gestures
    func didPanOnTiles(gestureRecognizer: UIPanGestureRecognizer) {
        let position = gestureRecognizer.locationInView(self.view)
        let touchedNode = getTouchedNode(position);
        let touchedTile = game_board.tileFromName((touchedNode?.name)!)
        
        // get beginning tile
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            initialTouchedTile = touchedTile
            lastTouchedTile = initialTouchedTile
        // once we've ended
        } else if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("row \(lastTouchedTile.row) column \(lastTouchedTile.column)")
            if lastTouchedTile.row != initialTouchedTile.row {
                game_board.changeRowColor(lastTouchedTile.column, color: 1)
            } else if lastTouchedTile.column != initialTouchedTile.column {
                game_board.changeColumnColor(lastTouchedTile.row, color: 1)
            }
        // while dragging
        } else {
            lastTouchedTile = touchedTile
        }
    }
    
    // handles sprite behavior (i.e. rotation, highlating) based on touch position
    func getTouchedNode(locationInView: CGPoint) -> SKNode? {
        // convert to the coord system of this scene class
        let convertedPosition = self.convertPointFromView(locationInView)
        let touchedSprite = self.nodeAtPoint(convertedPosition)
        
        return touchedSprite
    }
}
