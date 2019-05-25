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
    @IBOutlet var tableView: UITableView!
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        requestContactPermission()
    }
}

//MARKER: private extension
private extension ViewController {
    //ask for contact permission
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
        contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)

        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

//MARKER: table view data source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]
        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        if contact.imageDataAvailable, let imageData = contact.imageData {
            cell.contactImage.image = UIImage(data: imageData)
        }
        return cell
    }
}

//MARKER: table view delegate
extension ViewController: UITableViewDelegate {
    
}
