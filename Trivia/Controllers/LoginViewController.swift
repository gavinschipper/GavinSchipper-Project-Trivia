//
//  LoginViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 10-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    // unwind segue naar de login pagina vanaf een andere pagina
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Als de login button wordt ingedrukt worden de ingevulde gegevens gecontroleerd en als de gegevens kloppen wordt de gebruiker ingelogd bij de database en doorgestuurd naar de rest van de app.
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        //Als email, wachtwoord of beide leeg zijn krijgt de gebruiker een error
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert die de gebruiker vertelt dat ze iets moeten invullen bij email en wachtwoord.
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            //zorgt ervoor dat de alert weggeklikt kan worden
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            // Als er correct een wachtwoord en email is ingevuld, worden de gegevens gechecht met firebase
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                // Wordt uitgevoerd als de gegevens goed zijn
                if error == nil {
                    
                    // Go to startQuizViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabjesPagina")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                // Wordt uitgevoerd als de gegevens niet kloppen
                } else {
                    
                    //laat de gebruiker een alert zien met wat er precies fout is gegaan.
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    //zorgt ervoor dat de alert weggeklikt kan worden
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
