//
//  CreateAccountViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 10-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    // Als de create account button wordt geklikt wordt gecontroleerd of te ingevulde gegevens correct zijn. Als dit zo is wordt de data doorgestuurd naar Firebase.
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        
        // https://www.appcoda.com/firebase-login-signup/
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            // zorgt ervoor dat de alert weggeklikt kan worden
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                // Als er geen error is, ga terug naar login pagina
                if error == nil {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                    self.present(vc!, animated: true, completion: nil)
                    
                }
                
                // Als er een error is, laat een waarschuwing zien met wat het probleem is.
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    // zorgt ervoor dat de alert weggeklikt kan worden
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

