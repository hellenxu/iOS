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
    private var targetTime = 0
    private var timer: Timer!
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func startCountDown(_ sender: UIButton) {
        
        if let title = sender.currentTitle {
            print("selected: \(title)")
            
            if timer != nil {
                timer.invalidate()
            }
            infoTitle.text = "Cooking..."
            progressBar.progress = 0.0
            targetTime = cookingTimes[title] != nil ? cookingTimes[title]! : 0
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
            
            //TODO disable click
        }
    }
    
    @objc func updateProgress() {
        if currentTime < targetTime {
            print("\(currentTime) seconds past")
            currentTime += 1
            progressBar.progress = Float(currentTime) / Float(targetTime)
        }else{
            currentTime = 0
            timer.invalidate()
            infoTitle.text = "Done!!"
        }
    }
    
}
