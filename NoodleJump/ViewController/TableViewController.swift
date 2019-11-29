//
//  TableViewController.swift
//  NoodleJump
//
//  Created by Mia on 12/11/2019.
//  Copyright © 2019 Mia. All rights reserved.
//
import UIKit

class TableViewController : UITableViewController {
    
    var array = UserDefaults.standard.object(forKey: "playerScorePersist") as? [String] ?? [String]()
    
    
    @IBOutlet var highScoreTabel: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        array = UserDefaults.standard.object(forKey: "playerScorePersist") as? [String] ?? [String]()
        array.sort()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(array.count < 5){
           return array.count
        }else{
            return 5
        }
        
       }

     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highscores"
     }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        //if(GameScene.instance != nil) {
          //  let playerO = GameScene.instance.playerObj as Player?
           // let playerScore: CGFloat = playerO?.score ?? 0
        cell.textLabel?.text = "Score: \(array[indexPath.row])"
           return cell
    }
    
    
    
    
    
    
        
    
    
}
