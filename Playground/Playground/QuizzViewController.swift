//
//  QuizzViewController.swift
//  Playground
//
//  Created by Hellen on 2021-03-18.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class QuizzViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = "4 + 3 = 7"
    
    }
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        
    }
    
}
