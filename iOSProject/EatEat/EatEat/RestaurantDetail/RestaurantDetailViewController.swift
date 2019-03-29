//
//  RestaurantDetailViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-28.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(selectedRestaurant)
    }
    

}
