//
//  Buff.swift
//  NoodleJump
//
//  Created by Mia on 06/11/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import SpriteKit

class Buff {
    var sprite = SKSpriteNode()
    
    
    init(spriteName: String) {
    sprite = SKSpriteNode(imageNamed: spriteName)
    sprite.name = "Buff"
    sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width, height:sprite.size.height))
    sprite.physicsBody?.affectedByGravity = false
    sprite.physicsBody?.isDynamic = false
    sprite.physicsBody?.categoryBitMask = ColliderType.Buff
        
    }
}
