//
//  QuizController.swift
//  Trivia
//
//  Created by Gavin Schipper on 11-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import Foundation
import UIKit

class QuizController {

    let baseURL = URL(string: "https://opentdb.com/api.php?")!
    
    static let shared = QuizController()
    
    let query: [String: String] = [
        "amount": "10",
        "type": "multiple",
        ]
    
    // Verzamelt de data voor de quiz van de API
    func fetchTriviaQuestions(completion: @escaping (triviaQuestions?) -> Void) {
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let triviaQuestions = try? jsonDecoder.decode(triviaQuestions.self, from: data) {
                completion(triviaQuestions)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

