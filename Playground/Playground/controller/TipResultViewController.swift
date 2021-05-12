//
//  TipResultViewController.swift
//  Playground
//
//  Created by Hellen on 2021-05-04.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class TipResultViewController: UIViewController {
    var tipEach = ""
    var tip = ""
    var splitNumber = 0
    
    @IBOutlet weak var tipEachLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var recalculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipEachLabel.text = tipEach
        infoLabel.text = "Split between \(splitNumber) with \(tip) tip"
    }
    
    @IBAction func onRecalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
