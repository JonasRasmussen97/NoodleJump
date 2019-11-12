//
//  Settings.swift
//  NoodleJump
//
//  Created by Mia on 27/10/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1 // 01
    static let switchCategory: UInt32 = 0x1 << 1 // Shift all bits 10
}
