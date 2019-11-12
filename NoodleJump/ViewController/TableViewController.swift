//
//  TableViewController.swift
//  NoodleJump
//
//  Created by Mia on 12/11/2019.
//  Copyright © 2019 Mia. All rights reserved.
//
import UIKit

class TableViewController : UITableViewController {
    
    
    @IBOutlet var highScoreTabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 5
       }

     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highscores"
     }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        if(GameScene.instance != nil) {
            let playerO = GameScene.instance.playerObj as Player?
            let playerScore: CGFloat = playerO?.score ?? 0
        cell.textLabel?.text = "Score: \(String(describing: playerScore))"
           return cell
       }
        return cell
    }
    
    
    
    
    
    
        
    
    
}
