//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Craig Clayton on 6/30/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let manager = ExploreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.fetch()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        let item = manager.getItem(at: indexPath)
        cell.categoryName.text = item.name
        cell.imgExplore.image = UIImage(named: item.image)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    // Add Unwind here
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue) {}
}








































