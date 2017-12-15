//
//  HighscoreTableViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 14-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class HighscoreTableViewController: UITableViewController {
    
    var scoreList = [Score]()

    // Na het laden van de view controller wordt de data die is opgeslagen in de firebase database opgehaald. Deze data wordt in variabelen opgeslagen en in een Score struct opgeslagen. Nadat alle scores in een lijst zijn opgeslagen wordt de lijst gesorteerd van hoog naar laag.
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // https://www.simplifiedios.net/firebase-realtime-database-tutorial/
        
        let ref: DatabaseReference! = Database.database().reference().child("scores")
        
        ref.observe(.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.scoreList = []
                for scores in snapshot.children.allObjects as! [DataSnapshot] {
                    let scoreObject = scores.value as? [String: AnyObject]
                    let email = scoreObject?["email"]
                    let id = scoreObject?["id"]
                    let score = scoreObject!["score"]
                    
                    let scoreToBeAdded = Score(id: id as! String?, email: email as! String?, score: score as! Int?)
                    
                    self.scoreList.append(scoreToBeAdded)
                }
            self.scoreList.sort { $0.score! > $1.score! }
            self.tableView.reloadData()
            }
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    
    // Voor iedere score wordt een regel geplaatst
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }

    // de cellen worden gevuld met de scores en de bijbehorende user email.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscoreCell", for: indexPath) as! TableViewCell
        
        let score: Score
        
        score = scoreList[indexPath.row]
        
        cell.emailLabel.text = score.email
        cell.scoreLabel.text = String(describing: score.score!)

        return cell
    }
}
