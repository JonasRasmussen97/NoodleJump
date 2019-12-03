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
static let Field: UInt32 = 2
static let Enemy: UInt32 = 4
static let Buff: UInt32 = 8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    

    // Defines the SKAction when the player moves. It is set further down in the code.
    var action: SKAction = SKAction.moveTo(x: 0, duration: 1)
    
    // Defines the boundaries of the game field.
    var maxWidth: CGFloat = 0
    var maxHeight: CGFloat = 6000
    
    // Initializes the player with name.
    var playerObj = Player(playerName: "Jonas")
    
    var level1 = Level(numberOfFields_: 100)
    
    
    // Used to make a cam that follows the player.
    let cam = SKCameraNode()
    
    var first: CGFloat = 0.0
    var second: CGFloat = 0.0
    
    var gameIsOver = false
    var playerHighscoreList = [String]()
        
    
    
    // Everything that should be set upon switching scene.
    override func didMove(to view: SKView) {
        maxWidth = frame.size.width;
        playerObj.sprite.position = CGPoint(x: 0, y: 150)
        playerHighscoreList = UserDefaults.standard.object(forKey: "playerScorePersist") as? [String] ?? [String]()
        generateLevel()
       
        
    }
    
    // Everything that needs to continually update.
    override func update(_ currentTime: TimeInterval) {
        action = SKAction.moveTo(x: playerObj.destX, duration: 1)
        playerObj.sprite.run(action)
        cam.position.y = playerObj.sprite.position.y
          
        playerObj.checkVelocity()
        playerObj.movePlayerWithSensor()
        startScoreSystem()
        let minY = playerObj.sprite.position.y - frame.size.height/2
        checkFieldLoadHeight(minY: minY)

        checkBoundaries()
        
      }
    
    // Checks if the player reached the max width of the map and set the player back.
    func checkBoundaries () {
        if(playerObj.sprite.position.x >= frame.size.width / 2) {
            playerObj.sprite.removeAllActions()
            playerObj.sprite.position = CGPoint(x: (-maxWidth/2)+5, y: playerObj.sprite.position.y)
          //  print("HEY!")
        } else if(playerObj.sprite.position.x <= -frame.size.width/2) {
            playerObj.sprite.removeAllActions()
            playerObj.sprite.position = CGPoint(x: (maxWidth/2)-5, y: playerObj.sprite.position.y)
        } else {
            playerObj.sprite.run(action)
        }
        
    }
    
    // Sets the score of the player. Score is just the height.
    func startScoreSystem() {
        playerObj.playerScoreLabel.position.x = playerObj.sprite.position.x
        playerObj.playerScoreLabel.position.y = playerObj.sprite.position.y + 100
        playerObj.playerScoreLabel.text = "Height(Score): " + playerObj.score.description
        if(playerObj.sprite.position.y > playerObj.score){
                playerObj.score = playerObj.sprite.position.y
        }
        playerObj.defaults.set(playerObj.score, forKey: "saveScoreLocal")
        //print(playerObj.score)
    }
    
    // This function generates the level. This is where all the logic for the fields is located.
    // Such as how many fields, the maximum distance between them and so on.
    func generateLevel() {
        // For loop that creates fields.
        for i in 0...level1.fields.count - 1 {
            if(i > 0) {
                let previousPosition = level1.fields[i-1].position
                let randomX = CGFloat.random(in: (-maxWidth/2)...(maxWidth/2))
                var randomY = CGFloat.random(in: previousPosition.y...previousPosition.y+100)
                if(randomY - previousPosition.y <= 100) {
                    randomY += CGFloat.random(in: 20...120)
                }
                level1.fields[i].position = CGPoint(x: randomX, y: randomY)
                
                self.addChild(level1.fields[i])
                
                //checks whether the fields are colliding
                for j in 0...level1.fields.count - 1{
                    if(j > 0){
                        if(j != i){
                            if(level1.fields[i].intersects(level1.fields[j])){
                                level1.fields[j].removeFromParent()
                            }
                        }
                    }
                }
            }else{
                // Sets starting fields to ensure player does not fall to his death upon spawn.
               level1.fields[i].position.x = 0
               level1.fields[i].position.y = -10
               self.addChild(level1.fields[i])
            }
            
        }
        
        self.addChild((playerObj.playerScoreLabel))
        self.addChild(playerObj.sprite)
        self.physicsWorld.contactDelegate = self
        self.camera = cam
    }

    //check if fields are below screen and remove if they are
    func checkFieldLoadHeight(minY: CGFloat){
        for i in 0...level1.fields.count-1{
            if(level1.fields[i].position.y < minY){
                level1.fields[i].removeFromParent()
            }
            
            //checks if the player is lower than the lowest field
            if((playerObj.sprite.position.y < level1.fields[0].position.y - 50) && !gameIsOver){
                gameIsOver = true
                self.playerHighscoreList.append(playerObj.score.description)
                UserDefaults.standard.set(playerHighscoreList, forKey: "playerScorePersist")
                self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // What to do upon collision detected.
    func didBegin(_ contact: SKPhysicsContact) {
        let collision:UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if(collision == ColliderType.Player | ColliderType.Buff) {
            // Remove the buff node if the player collides with it.
            contact.bodyA.node?.removeFromParent()
        } else if(collision == ColliderType.Player | ColliderType.Field) {
            playerObj.sprite.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
            playerObj.sprite.run(SKAction.repeat(SKAction.animate(with: playerObj.playerJumpingFrames, timePerFrame: 0.1, resize: false, restore: true), count: 1))
          //  print("Collision!")
        }
      }
}
    
    
    

