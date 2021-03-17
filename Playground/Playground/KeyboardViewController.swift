//
//  KeyboardViewController.swift
//  Playground
//
//  Created by Hellen on 2021-03-16.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit
import AVFoundation

class KeyboardViewController: UIViewController {

    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        if let title = sender.currentTitle {
            playKeySound(title)
        }

    }
    
    func playKeySound(_ key: String) {
        if let url = Bundle.main.url(forResource: key, withExtension: "wav") {
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
    
}
