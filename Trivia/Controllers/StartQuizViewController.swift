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
    
    @IBAction func unwindToStartQuiz(segue: UIStoryboardSegue) {
        
    }

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
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartQuizSegue" {
            //let quizViewController = segue.destination as! QuizViewController
            //quizViewController.questions = self.questions
            
            let nav = segue.destination as! UINavigationController
            let svc = nav.topViewController as! QuizViewController
            svc.questions = self.questions
        }
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
