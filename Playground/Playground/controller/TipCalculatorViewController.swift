//
//  TipCalculatorViewController.swift
//  Playground
//
//  Created by Hellen on 2021-05-04.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    @IBOutlet weak var billAmtTextField: UITextField!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var twentyButton: UIButton!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    
    private let calculator: TipCalculator = TipCalculator()
    private var tip: Float = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTipChanged(_ sender: UIButton) {
        if let title = sender.currentTitle {
            tip = Float(title) ?? 0.0

            updateTipSelectedButtonState(title: title, target: zeroButton)
            updateTipSelectedButtonState(title: title, target: tenButton)
            updateTipSelectedButtonState(title: title, target: twentyButton)
        }
    }
    
    private func updateTipSelectedButtonState(title: String, target: UIButton) {
        if target.currentTitle == title {
            target.isSelected = true
        } else {
            target.isSelected = false
        }
    }
    
    @IBAction func onSplitNumberChanged(_ sender: UIStepper) {
        splitLabel.text = String(format: "%.f", sender.value)
    }
    
    @IBAction func onCalculatePressed(_ sender: UIButton) {
        let total = Float(billAmtTextField.text ?? "") ?? 0.0
        let number = Int(splitStepper.value)
        print("xxl-each-amt: \(calculator.calculateTip(total: total, tip: tip, splitNum: number))")
    }
}
