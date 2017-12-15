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
    
//    @IBAction func viewScoresButtonPressed(_ sender: Any) {
//        let vc = self.tabBarController
//        self.present(vc!, animated: true, completion: nil)
//    }
    
    var ref: DatabaseReference! = Database.database().reference().child("scores")
    var user = Auth.auth().currentUser!
    
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        showScoreLabel.text = String(score)
        addScore()
    }
    
    func addScore () {
        //Een key aanmaken voor de score
        let key = ref.childByAutoId().key
            
        //score creë met verschillende waardes
        let score: [String: Any] = ["id":key,
                                    "email": user.email!,
                                    "score": self.score
            ]
            
        //score toevoegen aan database
        ref.child(key).setValue(score)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
