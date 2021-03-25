//
//  QuizHub.swift
//  Playground
//
//  Created by Hellen on 2021-03-22.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct QuizHub{
    let questions = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True")
    ]
    
    let multiQuestions = [
        MultiOptionQuestion(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        MultiOptionQuestion(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        MultiOptionQuestion(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        MultiOptionQuestion(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        MultiOptionQuestion(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        MultiOptionQuestion(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        MultiOptionQuestion(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        MultiOptionQuestion(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        MultiOptionQuestion(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        MultiOptionQuestion(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    private var currentQuestionNum = 0
    private var currentScore = 0
    
    mutating func checkAnswer(_ userAnswer: String, _ isMultipleChoice: Bool) -> Bool {
        let expectedAnswer = isMultipleChoice ? multiQuestions[currentQuestionNum].correctAnswer : questions[currentQuestionNum].answer
        
        if userAnswer == expectedAnswer {
            currentScore += 1
            return true
        } else {
            return false
        }
    }
    
    func getCurrentQuestion(_ isMultipleChoice: Bool) -> String{
        let question = isMultipleChoice ? multiQuestions[currentQuestionNum].question : questions[currentQuestionNum].question
        return question
    }
    
    func getCurrentProgress(_ isMultipleChoice: Bool) -> Float {
        let totalAmt = isMultipleChoice ? multiQuestions.count : questions.count
        return Float(currentQuestionNum + 1) / Float(totalAmt)
    }
    
    mutating func nextQuestion(_ isMultipleChoice: Bool) {
        let totalAmt = isMultipleChoice ? multiQuestions.count : questions.count
        currentQuestionNum = (currentQuestionNum + 1) % totalAmt
    }
    
    mutating func getCurrentScore() -> Int {
        if currentQuestionNum == 0 {
            currentScore = 0
        }
        return currentScore
    }
    
    func getChoiceOne() -> String {
        return getChoice(index: 0)
    }
    
    func getChoiceTwo() -> String {
        return getChoice(index: 1)
    }
    
    func getChoiceThree() -> String {
        return getChoice(index: 2)
    }
    
    private func getChoice(index: Int) -> String {
        return multiQuestions[currentQuestionNum].answerOptions[index]
    }
}
