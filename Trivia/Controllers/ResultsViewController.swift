//
//  ResultsViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 14-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var showScoreLabel: UILabel!
    
    // referentie naar de firebase database
    var ref: DatabaseReference! = Database.database().reference().child("scores")
    
    // laad huidige gebruiker
    var user = Auth.auth().currentUser!
    
    var score = 0

    // laad de score zien die tijdens de quiz behaald is en voeg de score toe aan de database
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        showScoreLabel.text = String(score)
        addScore()
    }
    
    // functie die een score toevoegt aan de firebase database
    func addScore () {
        //Een key aanmaken voor de score
        let key = ref.childByAutoId().key
            
        //score creëren met verschillende waardes
        let score: [String: Any] = ["id":key,
                                    "email": user.email!,
                                    "score": self.score
            ]
            
        //score toevoegen aan database
        ref.child(key).setValue(score)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
