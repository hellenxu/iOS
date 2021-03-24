//
//  MultiOptionQuestion.swift
//  Playground
//
//  Created by Hellen on 2021-03-23.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct MultiOptionQuestion{
    let question: String
    let answerOptions: [String]
    let correctAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        question = q
        answerOptions = a
        self.correctAnswer = correctAnswer
    }
}
