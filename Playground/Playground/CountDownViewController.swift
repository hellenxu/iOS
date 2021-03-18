//
//  CountDownViewController.swift
//  Playground
//
//  Created by Hellen on 2021-03-17.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {
    private let cookingTimes : [String: Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    private var currentTime = 0
    private var timer: Timer!
    @IBOutlet weak var infoTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func startCountDown(_ sender: UIButton) {
        
        if let title = sender.currentTitle {
            print("selected: \(title)")
            
            if timer != nil {
                timer.invalidate()
            }
            
            currentTime = cookingTimes[title]!
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
            
            //TODO disable click
        }
    }
    
    @objc func updateProgress() {
        if currentTime > 0 {
            print("\(currentTime) seconds left")
            currentTime -= 1
        }else{
            timer.invalidate()
            infoTitle.text = "Done!!"
        }
    }
    
}
