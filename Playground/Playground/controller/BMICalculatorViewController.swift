//
//  BMICalculatorViewController.swift
//  Playground
//
//  Created by Hellen on 2021-04-13.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class BMICalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onHeightChanged(_ sender: UISlider) {
        print("xxl-height: \(sender.value)")
        
    }
    
    @IBAction func onWeightChanged(_ sender: UISlider) {
        print("xxl-weight: \(sender.value)")
    }
    
}
