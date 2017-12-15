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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI(with: self.questions)
    }
    
    // Update voor iedere nieuwe vraag de UI
    func updateUI(with questions: [triviaQuestion]) {
        singleAnswerStackView.isHidden = true
        
        self.questions = questions
        let currentQuestion = questions[questionIndex]
        let antwoorden = currentQuestion.answers.sorted()
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        
        questionLabel.text = currentQuestion.question.removingHTMLEntities
        
        updateStackView(using: antwoorden)
        
        currentScoreLabel.text = "Current score: \(score)"
        
        questionProgressView.setProgress(totalProgress, animated: true)
    }
    
    // Wanneer één van de singleAnswerButtons wordt geklikt, wordt gekeken of het bijbehorende antwoord overeenkomt met de correctAnswer. Als dit het geval is wordt de score met 1 verhoogd. Vervolgens wordt de volgende vraag aangeroepen.
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentQuestion = questions[questionIndex]
        var currentAnswers = currentQuestion.answers.sorted()
        
        switch sender {
        case singleButton1:
            if currentAnswers[0] == currentQuestion.correctAnswer {
                score += 1
            }
        case singleButton2:
            if currentAnswers[1] == currentQuestion.correctAnswer {
                score += 1
            }
        case singleButton3:
            if currentAnswers[2] == currentQuestion.correctAnswer {
                score += 1
            }
        case singleButton4:
            if currentAnswers[3] == currentQuestion.correctAnswer {
                score += 1
            }
        default:
            break
        }
        nextQuestion()
    }
    
    // checkt of de huidige index lager is dan het totale aantal vragen. Als dit zo is wordt de volgende vraag aangeroepen. Als dit niet zo is wordt de gebruiker doorgestuurd naar de ResultsViewController
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI(with: questions)
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    // de tekst van de antwoordbuttons wordt aangepast aan de antwoorden van de huidige vraag
    func updateStackView(using antwoorden: [String]) {
        singleAnswerStackView.isHidden = false
        singleButton1.setTitle(antwoorden[0].removingHTMLEntities, for: .normal)
        singleButton2.setTitle(antwoorden[1].removingHTMLEntities, for: .normal)
        singleButton3.setTitle(antwoorden[2].removingHTMLEntities, for: .normal)
        singleButton4.setTitle(antwoorden[3].removingHTMLEntities, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Stuurt de score die behaald is na het beantwoorden van alle vragen door naar de results pagina
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.score = score
        }
    }
    
}
