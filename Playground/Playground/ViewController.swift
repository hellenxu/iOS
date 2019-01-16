//
//  ViewController.swift
//  Playground
//
//  Created by Hellen on 2019-01-03.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var roundValue: Int = 0
    var scores: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
        
        let thumbImgNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImgNormal, for: .normal)

        let thumbImgHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImgHighlighted, for: .highlighted)

        let insects = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insects)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insects)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func showAlert() {
        let offset = abs(currentValue - targetValue)
        let currentScore = 100 - offset
        scores += currentScore
        
        let msg = "Your score is: \(currentScore)"
        let title: String
        if(offset == 0) {
            title = "Perfect!!!"
            //bonus
            scores += 100
        }else if(offset < 5) {
            title = "Awesome!!!"
            //bonus
            if(offset == 1) {
                scores += 50
            }
        } else if(offset < 10) {
            title = "Great!!!"
        } else {
            title = "Keep up~~"
        }
        
        let alert = UIAlertController(title:title, message:msg, preferredStyle:.alert)
        
        let action = UIAlertAction(title:"OK", style:.default,
                                   handler:{_ in
                                        self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
//        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
//        print("Current percentage is: \(slider.value)")
        currentValue = Int(roundf(slider.value))
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        roundValue += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        roundLabel.text = String(roundValue)
        scoreLabel.text = String(scores)
    }
    
    func startNewGame() {
        roundValue = 0
        scores = 0
        startNewRound()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
}

