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
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = Int(roundf(slider.value))
    }

    @IBAction func showAlert() {
        let msg = "Current percentage is: \(currentValue)"
        let alert = UIAlertController(title:"Result", message:msg, preferredStyle:.alert)
        
        let action = UIAlertAction(title:"OK", style:.default, handler:nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
//        print("Current percentage is: \(slider.value)")
        currentValue = Int(roundf(slider.value))
    }
}

