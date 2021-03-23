//
//  QuizzViewController.swift
//  Playground
//
//  Created by Hellen on 2021-03-18.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var quizHub = QuizHub()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        if let title = sender.currentTitle {
            if quizHub.checkAnswer(title) {
                print("xxl-right")
                sender.backgroundColor = UIColor.green
            } else {
                print("xxl-wrong")
                sender.backgroundColor = UIColor.red
            }
            
            quizHub.inCreaseCurrentQuestionNum()
            updateUI()
        }
    }
    
    func updateUI() {
        questionLabel.text = quizHub.getCurrentQuestion()
        progressBar.progress = quizHub.getCurrentProgress()
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
            self.trueButton.backgroundColor = UIColor.clear
            self.falseButton.backgroundColor = UIColor.clear
        })
    }
}
