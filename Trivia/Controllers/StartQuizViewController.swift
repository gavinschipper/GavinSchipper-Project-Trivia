//
//  startQuizViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 10-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit

class StartQuizViewController: UIViewController {
    
    var questions = [triviaQuestion]()
    
    // Unwind segue om naar de StartQuizViewController te gaan vanaf een andere pagina
    @IBAction func unwindToStartQuiz(segue: UIStoryboardSegue) {
        
    }
    
    // Laad de vragen voor de quiz
    override func viewDidLoad() {
        super.viewDidLoad()
        QuizController.shared.fetchTriviaQuestions { (triviaQuestions) in
            if let triviaQuestions = triviaQuestions {
                self.questions = triviaQuestions.results
                print(self.questions)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Stuur de geladen vragen door naar QuizViewController wanneer er op 'Start Quiz' gedrukt wordt.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartQuizSegue" {
            
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! QuizViewController
            svc.questions = self.questions
        }
    }

}
