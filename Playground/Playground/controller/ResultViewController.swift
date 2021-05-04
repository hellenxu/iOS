//
//  ResultViewController.swift
//  Playground
//
//  Created by Hellen on 2021-04-29.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    
    var bmiResult: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = String(format: "%.1f", bmiResult?.value ?? 0.0)
        adviceLabel.text = bmiResult?.advice ?? "No advice"
        view.backgroundColor = bmiResult?.backgroundColor ?? #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
    }
    
    @IBAction func onRecalculate(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
