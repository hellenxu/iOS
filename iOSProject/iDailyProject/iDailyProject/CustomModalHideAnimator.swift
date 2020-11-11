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
    
}
