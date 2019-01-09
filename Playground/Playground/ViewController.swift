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
    var roundValue: Int = 1000
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewRound()
    }

    @IBAction func showAlert() {
        let msg = "Current percentage is: \(currentValue) \nTarget percentage is: \(targetValue)"
        let alert = UIAlertController(title:"Result", message:msg, preferredStyle:.alert)
        
        let action = UIAlertAction(title:"OK", style:.default, handler:nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
//        print("Current percentage is: \(slider.value)")
        currentValue = Int(roundf(slider.value))
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        roundValue -= 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        roundLabel.text = String(roundValue)
    }
}

