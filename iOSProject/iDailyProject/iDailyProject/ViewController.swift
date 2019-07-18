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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        for cell in collectionView.visibleCells {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations:  {
                if editing {
                    cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
                } else {
                    cell.backgroundColor = .clear
                }
            }, completion: nil)
        }
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
        collectionView.collectionViewLayout = ContactCollectionViewLayout()
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.userDidLongPress(_:)))
        collectionView.addGestureRecognizer(longPressGestureRecognizer)
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    //selector for long press
    @objc func userDidLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let tappePoint = gestureRecognizer.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: tappePoint), let tappedCell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        
        if isEditing {
            reorderContact(tappedCell, atIndexPath: indexPath, gestureRecognizer: gestureRecognizer)
        } else {
            deleteContact(tappedCell, atIndexPath: indexPath)
        }
    }
    
    func reorderContact(_ cell: UICollectionViewCell, atIndexPath indexPath: IndexPath, gestureRecognizer: UILongPressGestureRecognizer) {
        print("xxl-indexPath: \(indexPath)")
        
        switch gestureRecognizer.state {
        case .began:
            collectionView.endInteractiveMovement()
            collectionView.beginInteractiveMovementForItem(at: indexPath)
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: nil)
        case .changed:
            let pos = gestureRecognizer.location(in: collectionView)
            collectionView.updateInteractiveMovementTargetPosition(pos)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.endInteractiveMovement()
        }
        
    }
    
    func deleteContact(_ tappedCell: UICollectionViewCell, atIndexPath indexPath: IndexPath) {
        let confirmationDialog = UIAlertController(title: "Delete contact?", message: "Are you sure you want to delete this contact?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Yes", style: .destructive, handler: {[weak self] _ in
            self?.contacts.remove(at: indexPath.row)
            self?.collectionView.deleteItems(at: [indexPath])
        })
        
        let cancelAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        confirmationDialog.addAction(deleteAction)
        confirmationDialog.addAction(cancelAction)
        
        if let popOver = confirmationDialog.popoverPresentationController {
            popOver.sourceView = tappedCell
            
            if let cell = tappedCell as? ContactCell {
                let imageCenter = cell.contactImage.center
                popOver.sourceRect = CGRect(x: imageCenter.x, y: imageCenter.y, width: 0, height: 0)
            }
        }
        
        present(confirmationDialog, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedContact = contacts.remove(at: sourceIndexPath.row)
        contacts.insert(movedContact, at: destinationIndexPath.row)
    }
}

//MARKER: CollectionView delegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ContactCell
            else {return }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut], animations: {
            cell.contactImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn], animations: {
                cell.contactImage.transform = .identity
            }, completion: { [weak self] _ in
                self?.performSegue(withIdentifier: "detailViewSegue", sender: self)
            })
        })
    }
}

//MARKER: CollectionView delegate flow layout
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = floor((collectionView.bounds.width - 2) / 4)
//        return CGSize(width: width, height: 90)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        let availableWidthForCells = collectionView.bounds.width - 2
//        let totalGutterSpace = availableWidthForCells.truncatingRemainder(dividingBy: 4)
//        let cellSpacing = totalGutterSpace / 2
//        return 1 + cellSpacing
//    }
//}

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

//MARKER: collection view prefetching
extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let contact = contacts[indexPath.count]
            contact.fetchImageIfNeeded()
        }
    }
}
