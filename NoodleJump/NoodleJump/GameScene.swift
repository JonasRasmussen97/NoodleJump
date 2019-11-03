//
//  GameScene.swift
//  NoodleJump
//
//  Created by Mia on 27/10/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import SpriteKit
import CoreMotion


// Collision check values.
struct ColliderType {
static let Player: UInt32 = 1
static let Enemy: UInt32 = 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    // Initializes the player with name.
    var playerObj = Player(playerName: "Jonas")
    
    var field = Field(spriteName: "").sprite
    
    var fields: [SKSpriteNode] = []
    
    // Used to make a cam that follows the player.
    let cam = SKCameraNode()
    
    var first: CGFloat = 0.0
    var second: CGFloat = 0.0
        
    
    override func didMove(to view: SKView) {
        let playerSprite = playerObj.sprite
        playerSprite.position = CGPoint(x: frame.size.width/2, y: frame.size.height/1)
       
        // For loop that creates fields. The max height the fields go to right now are 6000. and width 2000.
        for _ in 1...500 {
            field = Field(spriteName: "Table").sprite
            var xRandom = CGFloat.random(in: 1...1000)
            var yRandom = CGFloat.random(in: 1...6000)
            
                        field.position = CGPoint(x: frame.size.width/3 + xRandom, y: frame.size.height/3 + yRandom)
                        fields.append(field)
            self.addChild(field)
                }
            
           
            
             
            
        
       
            
        
        
        
        
        
        
      
            
        
        
    
        self.addChild((playerObj.playerScoreLabel))
        self.addChild(playerSprite)
        self.physicsWorld.contactDelegate = self
        self.camera = cam

        // Makes the player object move with the sensor.
            playerObj.movePlayerWithSensor()
        
}
    
    // Everything that needs to continually update.
    override func update(_ currentTime: TimeInterval) {
        let action = SKAction.moveTo(x: playerObj.destX, duration: 1)
        playerObj.sprite.run(action)
        cam.position = playerObj.sprite.position
          
        if(playerObj.sprite.physicsBody?.velocity.dy ?? 0 > 0.0) {
            playerObj.score += (playerObj.sprite.physicsBody?.velocity.dy ?? 0) * 0.0001
        }
        
        if(playerObj.sprite.physicsBody?.velocity.dy ?? 0 < 0.0) {
            playerObj.score -= (playerObj.sprite.physicsBody?.velocity.dy ?? 0) * 0.0001
        }
        
        playerObj.playerScoreLabel.position.x = playerObj.sprite.position.x
        playerObj.playerScoreLabel.position.y = playerObj.sprite.position.y + 100
        playerObj.playerScoreLabel.text = "Score: " + playerObj.score.description
         
        playerObj.checkVelocity()
      
        
      }
    
 
           
    
   
   
           
    // What to do upon contact between Player and field.
    func didBegin(_ contact: SKPhysicsContact) {
          
          var firstBody = SKPhysicsBody()
          var secondBody = SKPhysicsBody()
          
          if(contact.bodyA.node?.name == "Player") {
              firstBody = contact.bodyA
              secondBody = contact.bodyB
          } else {
              firstBody = contact.bodyB
              secondBody = contact.bodyA
          }
          
       
        
          if firstBody.node?.name == "Player" && secondBody.node?.name == "Field" {
              // 100 is the high that the player should jump up upon colliding with a field.
            playerObj.sprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
          }
      }
      
}
    
    
    

