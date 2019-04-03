//
//  RestaurantListViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-20.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController {
    
    var selectedRestaurant: RestaurantItem?
    var selectedCity: LocationItem?
    var selectedType: String?
    @IBOutlet weak var restaurantCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        guard let location = selectedCity?.city, let type = selectedType else { return }
        print("xxl-type \(type)")
        print(RestaurantAPIManager.loadJSON(file: location))
    }
}

//MARK: UICollectionViewDataSource
extension RestaurantListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
