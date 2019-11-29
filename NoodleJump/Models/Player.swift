//
//  Player.swift
//  NoodleJump
//
//  Created by Mia on 01/11/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import SpriteKit
import CoreMotion

class Player {
    
    let defaults = UserDefaults.standard
    var score:CGFloat = 0.0
    var playerScoreLabel = SKLabelNode()
    var sprite = SKSpriteNode()
    var playerJumpingFrames: [SKTexture] = []
    var playerAnimatedAtlas = SKTextureAtlas(named: "4-Jump")
    var name = ""
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var check: CGFloat = 0.0
    var floatSpeed: Double = 900
    
    
    init(playerName: String) {
        name = playerName
        sprite = SKSpriteNode(imageNamed: "Player1")
        sprite.name = "Player"
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.setScale(0.75)
        sprite.physicsBody?.density = 1
        sprite.physicsBody?.categoryBitMask = ColliderType.Player
        sprite.physicsBody?.collisionBitMask = ColliderType.Field | ColliderType.Buff
        sprite.physicsBody?.contactTestBitMask = ColliderType.Field | ColliderType.Buff
        sprite.physicsBody?.allowsRotation = false
        sprite.physicsBody?.affectedByGravity = true
        
        
        playerScoreLabel.fontSize = 14
        playerScoreLabel.name = "playerScoreLabel"
        playerScoreLabel.fontColor = UIColor.white
        
        animatePlayer()
      
       // print(playerAnimatedAtlas.textureNames.count)
        print(defaults.string(forKey: "saveScoreLocal"))
    }

    
    func animatePlayer() {
       for i in 1...playerAnimatedAtlas.textureNames.count {
            var spriteName = "Player\(i).png"
            playerJumpingFrames.append(SKTexture(imageNamed: spriteName))
        }
    }
    
    func movePlayerWithSensor() {
     
         if motionManager.isAccelerometerAvailable {
             motionManager.accelerometerUpdateInterval = 0.01
             motionManager.startAccelerometerUpdates(to: .main) {
                 (data, error) in
                     guard let data = data, error == nil else {
                     return
                 }
                let currentX = self.sprite.position.x
                  //  print(self.sprite.position.x)
                self.destX = currentX + CGFloat(data.acceleration.x * self.floatSpeed)
            }
             }
        
         }
    
    // Removes collision if the player is going up and enables it when player is falling down.
    // This is to prevent collision on tables from below.
    func checkVelocity() {
          if(sprite.physicsBody?.velocity.dy ?? 0 < check) {
             // print("It is below 0 now!")
              sprite.physicsBody?.categoryBitMask = ColliderType.Player
              sprite.physicsBody?.collisionBitMask = ColliderType.Field | ColliderType.Buff
              sprite.physicsBody?.contactTestBitMask = ColliderType.Field | ColliderType.Buff
          } else {
              sprite.physicsBody?.categoryBitMask = 0
              sprite.physicsBody?.collisionBitMask = 0
              sprite.physicsBody?.contactTestBitMask = 0
          }
    }
}

