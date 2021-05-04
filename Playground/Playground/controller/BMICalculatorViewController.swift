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
    
    private var calculator = BmiCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightSlider.value = weightSlider.maximumValue * 0.5
        weightLabel.text = String(format: "%.1fkg", weightSlider.value)
        heightSlider.value = heightSlider.maximumValue * 0.5
        heightLabel.text = String(format: "%.2fm", heightSlider.value)
    }
    
    @IBAction func onHeightChanged(_ sender: UISlider) {
        heightLabel.text = String(format: "%.2fm", sender.value)
    }
    
    @IBAction func onWeightChanged(_ sender: UISlider) {
        weightLabel.text = String(format: "%.1fKg", sender.value)
    }
    
    @IBAction func onCalculateClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toBmiResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBmiResult" {
            let resultVc = segue.destination as! ResultViewController
            resultVc.bmiResult = calculator.calculateBmi(weight: weightSlider.value, height: heightSlider.value)
        }
    }
}
