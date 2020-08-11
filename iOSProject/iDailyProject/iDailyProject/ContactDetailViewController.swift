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
    @IBOutlet var contactPhone: UILabel!
    @IBOutlet var contactEmail: UILabel!
    @IBOutlet var contactAddress: UILabel!
    
    var contact: Contact?
    
    var compactWidthConstraint: NSLayoutConstraint!
    var compactHeightConstraint: NSLayoutConstraint!
    var regularWidthConstraint: NSLayoutConstraint!
    var regularHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIApplication.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
        
        let views: [String: Any] = ["ContactImage": contactImage, "ContactName": contactName]
        var allConstraints = [NSLayoutConstraint]()
        
        // constraints for ContactImage
        compactWidthConstraint = contactImage.widthAnchor.constraint(equalToConstant: 60)
        compactHeightConstraint = contactImage.heightAnchor.constraint(equalToConstant: 60)
        regularWidthConstraint = contactImage.widthAnchor.constraint(equalToConstant: 120)
        regularHeightConstraint = contactImage.heightAnchor.constraint(equalToConstant: 120)
        let centerXConstraint = contactImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let verticalPositionConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[ContactImage]-[ContactName]", options: [.alignAllCenterX], metrics: nil, views: views)
        allConstraints += verticalPositionConstraints
        
        allConstraints.append(centerXConstraint)
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            allConstraints.append(regularWidthConstraint)
            allConstraints.append(regularHeightConstraint)
        } else {
            allConstraints.append(compactWidthConstraint)
            allConstraints.append(compactHeightConstraint)
        }
        
        NSLayoutConstraint.activate(allConstraints)
        
        if let contact = self.contact {
            contact.fetchImageIfNeeded { [weak self] image in
                self?.contactImage.image = image
            }
            contactName.text = "\(contact.givenName) \(contact.familyName)"
            contactPhone.text = contact.phoneNumber
            contactEmail.text = contact.emailAddress
            contactAddress.text = contact.address
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard let previousTrait = previousTraitCollection,
            (previousTrait.horizontalSizeClass != traitCollection.horizontalSizeClass || previousTrait.verticalSizeClass != traitCollection.verticalSizeClass)
        else { return }
        
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate([compactWidthConstraint, compactHeightConstraint])
            NSLayoutConstraint.activate([regularWidthConstraint, regularHeightConstraint])
        } else {
            NSLayoutConstraint.deactivate([regularWidthConstraint, regularHeightConstraint])
            NSLayoutConstraint.activate([compactWidthConstraint, compactHeightConstraint])
        }
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
