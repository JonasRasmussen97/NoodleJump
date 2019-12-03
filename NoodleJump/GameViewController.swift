//
//  GameViewController.swift
//  NoodleJump
//
//  Created by Mia on 27/10/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.bounds.size)
   
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
            
                // Present the scene
                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsPhysics = false
            view.showsNodeCount = true
        }
    }
    
   
    
    
   
    
  
}
