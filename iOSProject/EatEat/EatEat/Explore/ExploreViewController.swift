//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Craig Clayton on 6/30/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let manager = ExploreDataManager()
    var selectedCity: LocationItem?
    var headerView: ExploreHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        case Segue.restaurantList.rawValue:
            showRestaurantList(segue: segue)
        default:
            print("Segue not added")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue {
            guard selectedCity != nil else {
                showAlert()
                return false
            }
            return true
        }
        return true
    }
}

private extension ExploreViewController {
    func initialize() {
        manager.fetch()
    }
    
    func showLocationList(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
        let viewController = navController.topViewController as? LocationViewController
        else { return  }
        
        guard let city = selectedCity else { return }
        viewController.selectedCity = city
    }
    
    func showRestaurantList(segue: UIStoryboardSegue) {
        if let desViewController = segue.destination as? RestaurantListViewController,
            let city = selectedCity, let index = collectionView.indexPathsForSelectedItems?.first {
                desViewController.selectedType = manager.getItem(at: index).name
                desViewController.selectedCity = city
        }
    }
    
    func showAlert() {
        let alertContoller = UIAlertController(title: "Location Needed", message: "Please select a location", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertContoller.addAction(okAction)
        present(alertContoller, animated: true, completion: nil)
    }
    
    // Add Unwind here
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue) {}
    
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? LocationViewController {
            selectedCity = viewController.selectedCity
            if let location = selectedCity {
                headerView.locationLabel.text = location.full
            }
        }
    }
}

extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        headerView = header as? ExploreHeaderView
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
    
}
