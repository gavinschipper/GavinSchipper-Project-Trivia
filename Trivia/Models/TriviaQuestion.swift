//
//  QuestionData.swift
//  Trivia
//
//  Created by Gavin Schipper on 11-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import Foundation
import HTMLString

struct triviaQuestion: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    var answers: [String] {
        var answers = incorrectAnswers
        answers.append(correctAnswer)
        
        return answers
    }

    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

struct Answer {
    var text: String
}

struct triviaQuestions: Codable {
    let results: [triviaQuestion]
}

