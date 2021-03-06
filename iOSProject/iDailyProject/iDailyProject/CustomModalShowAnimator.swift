//
//  CustomModalShowAnimator.swift
//  iDailyProject
//
//  Created by Hellen on 2020-10-27.
//  Copyright © 2020 Six. All rights reserved.
//

import UIKit

class CustomModalShowAnimator: NSObject {

    
    
}

extension CustomModalShowAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        else { return }
        
        let transitionContainer = transitionContext.containerView
        
        var transform = CGAffineTransform.identity
        transform = transform.concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
        transform = transform.concatenating(CGAffineTransform(translationX: 0, y: -200))
        // make sure destination viewcontroller off screen
        
        destViewController.view.transform = transform
        destViewController.view.alpha = 0
        
        transitionContainer.addSubview(destViewController.view)
        
        let animationTiming = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 1, dy: 0))
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), timingParameters: animationTiming)
        animator.addAnimations {
            destViewController.view.transform = CGAffineTransform.identity
            destViewController.view.alpha = 1
        }
        animator.addCompletion {finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}
