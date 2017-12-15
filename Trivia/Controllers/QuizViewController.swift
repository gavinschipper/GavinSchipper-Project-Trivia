//
//  QuizViewController.swift
//  Trivia
//
//  Created by Gavin Schipper on 11-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import UIKit
import HTMLString

class QuizViewController: UIViewController {
    
    var questions = [triviaQuestion]()
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleAnswerStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var score = 0
    var questionIndex = 0
    var answersChosen: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI(with: self.questions)
//        QuizController.shared.fetchTriviaQuestions { (triviaQuestions) in
//            if let triviaQuestions = triviaQuestions {
//                self.updateUI(with: triviaQuestions.results)
//            }
//        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentQuestion = questions[questionIndex]
        var currentAnswers = currentQuestion.answers.sorted()
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
            if currentAnswers[0] == currentQuestion.correctAnswer {
                score += 1
            }
        case singleButton2:
            answersChosen.append(currentAnswers[1])
            if currentAnswers[1] == currentQuestion.correctAnswer {
                score += 1
            }
        case singleButton3:
            answersChosen.append(currentAnswers[2])
            if currentAnswers[2] == currentQuestion.correctAnswer {
                score += 1
            }
        case singleButton4:
            answersChosen.append(currentAnswers[3])
            if currentAnswers[3] == currentQuestion.correctAnswer {
                score += 1
            }
        default:
            break
        }
        
        nextQuestion()
    }
    
    func updateUI(with questions: [triviaQuestion]) {
        singleAnswerStackView.isHidden = true
        
        self.questions = questions
        let currentQuestion = questions[questionIndex]
        let antwoorden = currentQuestion.answers.sorted()
        
        print(antwoorden)
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.question.removingHTMLEntities
        updateStackView(using: antwoorden)
        currentScoreLabel.text = "Current score: \(score)"
        questionProgressView.setProgress(totalProgress, animated: true)
        
        print(answersChosen)
        print(score)
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI(with: questions)
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    func updateStackView(using antwoorden: [String]) {
        singleAnswerStackView.isHidden = false
        singleButton1.setTitle(antwoorden[0].removingHTMLEntities, for: .normal)
        singleButton2.setTitle(antwoorden[1].removingHTMLEntities, for: .normal)
        singleButton3.setTitle(antwoorden[2].removingHTMLEntities, for: .normal)
        singleButton4.setTitle(antwoorden[3].removingHTMLEntities, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.score = score
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
