//
//  CustomModalHideAnimator.swift
//  iDailyProject
//
//  Created by Hellen on 2020-11-10.
//  Copyright © 2020 Six. All rights reserved.
//

import UIKit

class CustomModalHideAnimator: UIPercentDrivenInteractiveTransition {
    let viewController: UIViewController
    
    init(withViewController viewController: UIViewController) {
        self.viewController = viewController
        
        super.init()
        
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgePan(gestureRecognizer:)))
        panGesture.edges = .left
        viewController.view.addGestureRecognizer(panGesture)
    }
    
    @objc func handleEdgePan(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let panTranslation = gestureRecognizer.translation(in: viewController.view)
        let animationProgress = min(max(panTranslation.x / 200, 0.0), 1.0)
        
        switch gestureRecognizer.state {
        case .began:
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            update(animationProgress)
            break
        case .ended:
            if animationProgress < 0.5 {
                cancel()
            } else {
                finish()
            }
            break
        default:
            cancel()
            break
        }
    }
}
