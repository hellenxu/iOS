//
//  ContactDetailViewController.swift
//  iDailyProject
//
//  Created by Hellen on 2020-07-23.
//  Copyright © 2020 Six. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    @IBOutlet var scrollViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var contactImage: UIImageView!
    @IBOutlet var contactName: UILabel!
    
    var compactWidthConstraint: NSLayoutConstraint!
    var compactHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIApplication.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
        
        let views: [String: Any] = ["ContactImage": contactImage, "ContactName": contactName]
        var allConstraints = [NSLayoutConstraint]()
        
        // constraints for ContactImage
        compactWidthConstraint = contactImage.widthAnchor.constraint(equalToConstant: 60)
        compactHeightConstraint = contactImage.heightAnchor.constraint(equalToConstant: 60)
        let centerXConstraint = contactImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let verticalPositionConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[ContactImage]-[ContactName]", options: [.alignAllCenterX], metrics: nil, views: views)
        allConstraints += verticalPositionConstraints
        
        allConstraints.append(centerXConstraint)
        allConstraints.append(compactWidthConstraint)
        allConstraints.append(compactHeightConstraint)
        
        NSLayoutConstraint.activate(allConstraints)
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let animDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        scrollViewBottomConstraint.constant = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: TimeInterval(animDuration), animations: {[weak self] in self?.view.layoutIfNeeded()})
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let animDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        scrollViewBottomConstraint.constant = 0
        UIView.animate(withDuration: TimeInterval(animDuration), animations: {[weak self] in self?.view.layoutIfNeeded()})
    }
}
