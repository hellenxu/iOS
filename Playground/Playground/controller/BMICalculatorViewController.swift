//
//  BMICalculatorViewController.swift
//  Playground
//
//  Created by Hellen on 2021-04-13.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onHeightChanged(_ sender: UISlider) {
        print("xxl-height: \(sender.value)")
        heightLabel.text = String(format: "%.2fm", sender.value)
    }
    
    @IBAction func onWeightChanged(_ sender: UISlider) {
        print("xxl-weight: \(sender.value)")
        weightLabel.text = String(format: "%.2fKg", sender.value)
    }
    
}
