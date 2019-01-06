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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func showAlert() {
        let alert = UIAlertController(title:"TestTitle", message:"TestMessage", preferredStyle:.alert)
        
        let action = UIAlertAction(title:"ActionOK", style:.default, handler:nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("Current percentage is: \(slider.value)")
    }
}

