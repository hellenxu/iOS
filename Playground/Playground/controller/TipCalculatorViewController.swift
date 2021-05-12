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
    private var selectedTip = "10%"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTipChanged(_ sender: UIButton) {
        if let title = sender.currentTitle {
            selectedTip = title

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
        performSegue(withIdentifier: "toResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toResult") {
            let total = Float(billAmtTextField.text ?? "") ?? 0.0
            let number = Int(splitStepper.value)
            let tip = Float(selectedTip) ?? 0.0
            let destinationVc = segue.destination as! TipResultViewController
            destinationVc.tipEach = calculator.calculateTip(total: total, tip: tip, splitNum: number)
            destinationVc.splitNumber = number
            destinationVc.tip = selectedTip
            print("xxl-prepare: \(selectedTip)")
        }
    }
}
