//
//  AccountViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 10-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var showEmailLabel: UILabel!
    
    // Laad de currentUser en verander het emailLabel naar de email van de gebruiker
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        let email = user?.email
        
        showEmailLabel.text = email
    }
    
    // Log de gebruiker uit wanneer er op de log out button geklikt wordt.
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
