//
//  ViewController.swift
//  iDailyProject
//
//  Created by Hellen on 2019-01-16.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestContactPermission()
    }


}

//MARKER: ask for contact permission
private extension ViewController {
    func requestContactPermission() {
        let store = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        if authorizationStatus == .notDetermined {
            print("xxl-request")
            store.requestAccess(for: .contacts) {[weak self] didAuthorize, error in
                if didAuthorize {
                    self?.retrieveContacts(from: store)
                }
            }
        } else if authorizationStatus == .authorized {
            print("xxl-authorized")
            retrieveContacts(from: store)
        }
    }
    
    func retrieveContacts (from store: CNContactStore) {
        let containerId = store.defaultContainerIdentifier()
        let predicate = CNContact.predicateForContactsInContainer(withIdentifier: containerId)
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                           CNContactFamilyNameKey as CNKeyDescriptor,
                           CNContactImageDataAvailableKey as CNKeyDescriptor,
                           CNContactImageDataKey as CNKeyDescriptor]
        let contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
        
        print("xxl-\(contacts)")
    }
}
