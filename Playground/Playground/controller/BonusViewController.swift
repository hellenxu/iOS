//
//  BonusViewController.swift
//  Playground
//
//  Created by Hellen on 2020-10-26.
//  Copyright © 2020 Six. All rights reserved.
//

import UIKit

class BonusViewController : UIViewController {

    @IBOutlet weak var square1: UIView!
    @IBOutlet weak var square2: UIView!
    @IBOutlet weak var square3: UIView!
    
    var animator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let squares: [UIDynamicItem] = [square1, square2, square3]
        animator = UIDynamicAnimator(referenceView: view)
        let gravityBehavior = UIGravityBehavior(items: squares)
        animator.addBehavior(gravityBehavior)
        
        var anchorX = 250
        for square in squares {
            let anchorPoint = CGPoint(x: anchorX, y: 0)
            anchorX -= 30
            let attachBehavior = UIAttachmentBehavior(item: square, attachedToAnchor: anchorPoint)
            attachBehavior.damping = 0.7
            animator.addBehavior(attachBehavior)
            
            let dynamicBehavior = UIDynamicItemBehavior()
            dynamicBehavior.addItem(square)
            dynamicBehavior.density = CGFloat(arc4random_uniform(3) + 1)
            dynamicBehavior.elasticity = 0.7
            animator.addBehavior(dynamicBehavior)
        }
    
        let collisionsBehavior = UICollisionBehavior(items: squares)
        animator.addBehavior(collisionsBehavior)
    }
    
}
