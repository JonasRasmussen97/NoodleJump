//
//  HomeViewController.swift
//  NoodleJump
//
//  Created by Mia on 27/10/2019.
//  Copyright © 2019 Mia. All rights reserved.
//

import UIKit
import SpriteKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // UserDefaults.standard.removeObject(forKey: "playerScorePersist")
    }
    
    @IBAction func modalDismissed(segue: UIStoryboardSegue) {
        self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

}

