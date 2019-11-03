//
//  Field.swift
//  NoodleJump
//
//  Created by Mia on 01/11/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import SpriteKit
import CoreMotion

class Field {
    
    var sprite = SKSpriteNode()
  
    init(spriteName: String) {
        sprite = SKSpriteNode(imageNamed: spriteName)
        sprite.name = "Field"
        sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width, height:1))
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.isDynamic = false
        sprite.physicsBody?.categoryBitMask = ColliderType.Enemy
    }
    
    
    
}
