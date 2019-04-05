//
//  RestaurantListViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-20.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController {
    
    var manager = RestaurantDataManager()
    var selectedRestaurant: RestaurantItem?
    var selectedCity: LocationItem?
    var selectedType: String?
    @IBOutlet weak var restaurantCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        createData()
        setupTitle()
    }
}

//MARK: private extension
extension RestaurantListViewController {
    func createData() {
        guard let location = selectedCity?.city, let filter = selectedType else {return}
        manager.fetch(by: location, withFilter: filter) {_ in
            if manager.numberOfItems() > 0 {
                restaurantCollection.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: restaurantCollection.frame.width, height: restaurantCollection.frame.height))
                view.set(title: "Restauratns")
                view.set(desc: "No restaurants found.")
                restaurantCollection.backgroundView = view
            }
            restaurantCollection.reloadData()
        }
    }
    
    func setupTitle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let city = selectedCity?.city, let state = selectedCity?.state {
            title = "\(city.uppercased()), \(state.uppercased())"
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: UICollectionViewDataSource
extension RestaurantListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let item = manager.restaurantItem(at: indexPath)
        if let name = item.name {cell.lblTitle.text = name}
        let cuisines = item.cuisines.joined(separator: ", ")
        cell.lblCuisine.text = cuisines
        if let image = item.imageURL {
            if let url = URL(string: image) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.imgRestaurant.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
}
