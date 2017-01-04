//
//  GameScene.swift
//  Starfield
//
//  Created by William Wright on 1/4/15.
//  Copyright (c) 2015 William Wright. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // scene bounderies
    let lower_x_boud : CGFloat = 0.0
    let lower_y_boud : CGFloat = 0.0
    var higher_x_bound : CGFloat = 0.0
    var higher_y_bound : CGFloat = 0.0
    
    //star layers one properties
    var star_layer : [[SKSpriteNode]] = []
    var star_layer_speed : [CGFloat]  = []
    var star_layer_color : [SKColor] = []
    var star_layer_count : [Int] = []
    
    // scroll direction
    var x_dir: CGFloat = 1.0
    var y_dir: CGFloat = 0.0
    
    
    //deltaTime
    var lastUpdate : NSTimeInterval = 0
    // 1/60 ~> 0.0166
    var deltaTime : CGFloat = 0.01666
    
    // used to demo 8 way scrolling
    var currentDir = 1
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // set the screen color
        self.backgroundColor = SKColor.blackColor()
        
        // set the boundries
        higher_x_bound = self.frame.width
        higher_y_bound = self.frame.height
        
        
        // create a dummy sprite 
        let dummySprite = SKSpriteNode(imageNamed: "star")
        
        // create the 3 star layers
        star_layer = [[dummySprite],[dummySprite],[dummySprite]]
        
        //set layer 0
        star_layer_count.append(50)
        star_layer_speed.append(30.0)
        star_layer_color.append(SKColor.whiteColor())
        
        //set layer 1
        star_layer_count.append(50)
        star_layer_speed.append(20.0)
        star_layer_color.append(SKColor.yellowColor())
        
        //set layer 2
        star_layer_count.append(50)
        star_layer_speed.append(10.0)
        star_layer_color.append(SKColor.redColor())
        
        
        
        
        //draw all the stars in all the layers
        for starLayers in 0...2 {
            
            //draw all the stars in a single layer
            for index in 1...star_layer_count[starLayers] {
                
            
                let sprite = SKSpriteNode(imageNamed: "star")
                // get a random position for the star
                let x_pos = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * higher_x_bound
                let y_pos = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * higher_y_bound
                sprite.position = CGPointMake(x_pos, y_pos)
                // set the correct color for the star in that layer
                sprite.colorBlendFactor = 1.0
                sprite.color = star_layer_color[starLayers]
                star_layer[starLayers].append(sprite)
                self.addChild(sprite)
                
            }
        }
        
        var ground = SKNode()
        ground.position = CGPointMake(0,0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.width, 1))
        ground.physicsBody! .dynamic = false
        
        self.addChild(ground)
        
    }

    
    
override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        //change direction when screen is tapped
        for touch: AnyObject in touches {
            
            switch currentDir {
                
            case 0:
                x_dir =  0.0
                y_dir = -1.0
                currentDir++
                
            case 1:
                x_dir = -1.0
                y_dir = -1.0
                currentDir++
                
            case 2:
                x_dir = -1.0
                y_dir =  0.0
                currentDir++
                
            case 3:
                x_dir = -1.0
                y_dir =  1.0
                currentDir++
                
                
            case 4:
                x_dir =  0.0
                y_dir =  1.0
                currentDir++
                
            case 5:
                x_dir =  1.0
                y_dir =  1.0
                currentDir++
                
            case 6:
                x_dir =  1.0
                y_dir =  0.0
                currentDir++
                
            case 7:
                x_dir =  1.0
                y_dir =  -1.0
                currentDir = 0
                
            default:
                x_dir = 0.0
                y_dir = 0.0
                currentDir = 0
                
                
                
                
                
            }

            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        deltaTime = CGFloat( currentTime - lastUpdate)
        lastUpdate = currentTime
        
        if deltaTime > 1.0 {
            deltaTime = 0.0166
        }
        
        //move starfield
        for index in 0...2 {
            
            MoveSingleLayer(star_layer[index], speed: star_layer_speed[index])
    
        }
    }
    
    
    func MoveSingleLayer(star_layer:[SKSpriteNode],speed:CGFloat) {
        
        var sprite:SKSpriteNode
        var new_x:CGFloat = 0.0
        var new_y:CGFloat = 0.0
        
        for index in 0...star_layer.count-1 {
            
            sprite = star_layer[index]
            new_x = sprite.position.x + x_dir * speed * deltaTime
            new_y = sprite.position.y + y_dir * speed * deltaTime
            
            sprite.position = boundCheck( CGPointMake(new_x, new_y) )
        }
        
        
    }
    
    
    
    func boundCheck(pos: CGPoint) -> CGPoint {
        var x = pos.x
        var y = pos.y
        
        
        if x < 0 {
            x += higher_x_bound
        }
        
        if y < 0 {
            
            y += higher_y_bound
        }
        
        if x > higher_x_bound {
            x -= higher_x_bound
        }
        
        if y > higher_y_bound {
            y -= higher_y_bound
        }
        
        return CGPointMake(x, y)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
