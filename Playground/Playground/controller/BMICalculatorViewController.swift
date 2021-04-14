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
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onHeightChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2fm", sender.value)
    }
    
    @IBAction func onWeightChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.1fKg", sender.value)
    }
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        let weight = weightSlider.value
        let height = heightSlider.value
        let bmi = weight / pow(height, 2)
        // bmi will be correct if both sliders are moved.
        print("xxl-bmi: \(bmi)")
    }
}
