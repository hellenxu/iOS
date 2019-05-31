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
    @IBOutlet var collectionView: UICollectionView!
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        requestContactPermission()
    }
}

//MARKER: private extension
private extension ViewController {
    //setup views
    func setupViews() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.rowHeight = 60
//        navigationItem.leftBarButtonItem = editButtonItem
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
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
        contacts = try! store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch).map {Contact(contact: $0)}
        
        DispatchQueue.main.async {[weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARKER: CollectionView data source
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contactCell", for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]
        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
        contact.fetchImageIfNeeded {image in
            cell.contactImage.image = image
        }
        return cell
    }
}

//MARKER: CollectionView delegate
extension ViewController: UICollectionViewDelegate {
    
}

//MARKER: table view data source
//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return contacts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactCell
//        let contact = contacts[indexPath.row]
//        cell.nameLabel.text = "\(contact.givenName) \(contact.familyName)"
//        contact.fetchImageIfNeeded {image in
//            cell.contactImage.image = image
//        }
//        return cell
//    }
//}

//MARKER: table view delegate
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let contact = contacts[indexPath.row]
//        let alertController = UIAlertController(title: "Contact tapped", message: "You tapped \(contact.givenName)", preferredStyle: .alert)
//        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: {action in
//            tableView.deselectRow(at: indexPath, animated: true)
//        })
//        alertController.addAction(dismissAction)
//        present(alertController, animated: true, completion: nil)
//    }

//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteHandler: UIContextualAction.Handler = { [weak self] action, view, callback in
//            self?.contacts.remove(at: indexPath.row)
//            self?.tableView.beginUpdates()
//            self?.tableView.deleteRows(at: [indexPath], with: .fade)
//            self?.tableView.endUpdates()
//            callback(true)
//        }
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: deleteHandler)
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let contact = contacts.remove(at: sourceIndexPath.row)
//        contacts.insert(contact, at: destinationIndexPath.row)
//    }
//}

//MARKER: prefetching
//extension ViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            let contact = contacts[indexPath.row]
//            contact.fetchImageIfNeeded()
//        }
//    }
//}
