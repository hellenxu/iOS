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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIApplication.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
        
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
