//
//  Score.swift
//  Trivia
//
//  Created by Gavin Schipper on 14-12-17.
//  Copyright © 2017 Gavin Schipper. All rights reserved.
//

import Foundation

struct Score {
    
    var id: String?
    var email: String?
    var score: Int?
    
    init(id: String?, email: String?, score: Int?){
        self.id = id
        self.email = email
        self.score = score
    }
}
