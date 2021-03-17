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
        
//        if let title = sender.currentTitle {
//            playKeySound(title)
//        }
        
        dimAnim(sender)
    }
    
    func playKeySound(_ key: String) {
        if let url = Bundle.main.url(forResource: key, withExtension: "wav") {
            player = try! AVAudioPlayer(contentsOf: url)
            player.play()
        }
    }
    
    func dimAnim(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.alpha = 0.5
        }, completion: {_ in
            sender.alpha = 1
        })
    }
}
