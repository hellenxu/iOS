//
//  DestinyViewController.swift
//  Playground
//
//  Created by Hellen on 2021-04-12.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class DestinyViewController: UIViewController {
    
    @IBOutlet weak var storyDescription: UILabel!
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    
    private var storyHub = StoryHub()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        storyDescription.text = storyHub.getCurrentStoryDescription()
        choiceOne.setTitle(storyHub.getChoiceOne(), for: UIControl.State.normal)
        choiceTwo.setTitle(storyHub.getChoiceTwo(), for: UIControl.State.normal)
    }
    
    @IBAction func submitChoice(_ sender: UIButton) {
        if let title = sender.currentTitle {
            storyHub.updateCurrentStoryIndex(choice: title)
            updateUI()
        }
    }
    
}
