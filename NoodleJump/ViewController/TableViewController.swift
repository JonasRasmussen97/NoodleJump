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
        array = array.sorted() { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedDescending }
    }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
        }
        
       
    
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highscores"
     }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
     
        cell.textLabel?.text = "Score: \(array[indexPath.row])"
           return cell
    }
    
    
    
    
    
    
        
    
    
}
