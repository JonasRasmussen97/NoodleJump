//
//  Level.swift
//  NoodleJump
//
//  Created by Mia on 03/11/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import SpriteKit

class Level {

    // Contains all fields that will be in the level.
    var fields: [SKSpriteNode] = [SKSpriteNode]()
    var startFields: [SKSpriteNode] = [SKSpriteNode]()
    var numberOfFields = 0

    init(numberOfFields_: Int) {
        self.numberOfFields = numberOfFields_
        generateFields()
    }
    

    func generateFields() {
        // For loop that creates fields and puts them in the array.
        for _ in 0...numberOfFields {
            fields.append(Field(spriteName: "Table").sprite)
        
        }
        // For loop that creates the starting fields and puts them in another array.
        for _ in 1...3 {
            startFields.append(Field(spriteName: "Table").sprite)
        }
        
        
        
        
        
    }
    
    
}
