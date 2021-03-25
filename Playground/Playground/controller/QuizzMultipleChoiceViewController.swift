//
//  QuizzMultipleChoiceViewController.swift
//  Playground
//
//  Created by Hellen on 2021-03-24.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class QuizzMultipleChoiceViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceOneButton: UIButton!
    @IBOutlet weak var choiceTwoButton: UIButton!
    @IBOutlet weak var choiceThreeButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!

    private var quizHub = QuizHub()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        if let title = sender.currentTitle {
            if quizHub.checkAnswer(title, true) {
                print("xxl-right")
                sender.backgroundColor = UIColor.green
            } else {
                print("xxl-wrong")
                sender.backgroundColor = UIColor.red
            }
            
            quizHub.nextQuestion(true)
            updateUI()
        }
    }
    
    func updateUI() {
        questionLabel.text = quizHub.getCurrentQuestion(true)
        choiceOneButton.setTitle(quizHub.getChoiceOne(), for: UIControl.State.normal)
        choiceTwoButton.setTitle(quizHub.getChoiceTwo(), for: UIControl.State.normal)
        choiceThreeButton.setTitle(quizHub.getChoiceThree(), for: UIControl.State.normal)
        progressView.progress = quizHub.getCurrentProgress(true)
        scoreLabel.text = "Score: \(String(describing: quizHub.getCurrentScore()))"
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: {_ in
            self.choiceOneButton.backgroundColor = UIColor.clear
            self.choiceTwoButton.backgroundColor = UIColor.clear
            self.choiceThreeButton.backgroundColor = UIColor.clear
        })
    }
}
