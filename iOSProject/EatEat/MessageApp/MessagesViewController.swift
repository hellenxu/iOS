//
//  MessagesViewController.swift
//  MessageApp
//
//  Created by Hellen on 2019-05-09.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import Messages
import EatDataKit

class MessagesViewController: MSMessagesAppViewController {
    @IBOutlet var collectionView: UICollectionView!
    let manager = RestaurantDataManager()
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARKER: private extension
private extension MessagesViewController {
    
    func initialize() {
        setupCollectionView()
        manager.fetch(by: "Chicago", completionHandler: { _ in
            self.collectionView.reloadData()
        })
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        collectionView.collectionViewLayout = flow
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func createMessage(with restaurant: RestaurantItem) {
        if let conversation = activeConversation {
            let layout = MSMessageTemplateLayout()
            layout.image = UIImage(named: "restaurant-detail")
            layout.caption = "Table for 7, tonight at 10:00 PM"
            layout.imageTitle = restaurant.name
            layout.imageSubtitle = restaurant.subtitle
            
            let message = MSMessage()
            message.layout = layout
            message.url = URL(string: "emptyURL")
            
            conversation.insert(message, completionHandler: { (error: Error?) in
                if error != nil {
                    print("there was an error (error)")
                } else {
                    self.requestPresentationStyle(.compact)
                }
            })
        }
    }
}

extension MessagesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantMessageCell
        let item = manager.restaurantItem(at: indexPath)
        if let name = item.name {cell.lblTitle.text = name}
        if let address = item.address {cell.lblCity.text = address}
        if let cuisines = item.subtitle {cell.lblCuisine.text = cuisines}
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = self.collectionView.frame.size.width - 14
        return CGSize(width: cellWidth, height: 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRestaurant = manager.restaurantItem(at: indexPath)
        guard let restaurant = selectedRestaurant else {return }
        createMessage(with: restaurant)
    }
}
