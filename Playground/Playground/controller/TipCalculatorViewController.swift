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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTipChanged(_ sender: UIButton) {
        if let title = sender.currentTitle {
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
        
    }
    
    @IBAction func onCalculatePressed(_ sender: UIButton) {
        
    }
}
