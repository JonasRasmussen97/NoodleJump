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
    
    var score:CGFloat = 0.0
    var playerScoreLabel = SKLabelNode()
    var name = ""
    var sprite = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    var check: CGFloat = 0.0
    
    
    init(playerName: String) {
        name = playerName
        sprite = SKSpriteNode(imageNamed: "Player1")
        sprite.name = "Player"
        sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        sprite.physicsBody?.density = 1
        sprite.physicsBody?.categoryBitMask = ColliderType.Player
        sprite.physicsBody?.collisionBitMask = ColliderType.Enemy
        sprite.physicsBody?.contactTestBitMask = ColliderType.Enemy
        sprite.physicsBody?.allowsRotation = false
        
        
        playerScoreLabel.fontSize = 14
        playerScoreLabel.name = "playerScoreLabel"
        playerScoreLabel.fontColor = UIColor.white
      
        
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
             self.destX = currentX + CGFloat(data.acceleration.x * 900)
                 }
             }
         }
    
    func checkVelocity() {
          if(sprite.physicsBody?.velocity.dy ?? 0 < check) {
                 // print("It is below 0 now!")
                  sprite.physicsBody?.categoryBitMask = ColliderType.Player
                  sprite.physicsBody?.collisionBitMask = ColliderType.Enemy
                  sprite.physicsBody?.contactTestBitMask = ColliderType.Enemy
              } else {
                  sprite.physicsBody?.categoryBitMask = 0
                  sprite.physicsBody?.collisionBitMask = 0
              sprite.physicsBody?.contactTestBitMask = 0
                  
                //  print("It is not below 0")
              }

}
}

