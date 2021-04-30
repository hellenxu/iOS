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
    
    var bmiResult: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel.text = String(format: "%.1f", bmiResult)
    }
    
    @IBAction func onRecalculate(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
