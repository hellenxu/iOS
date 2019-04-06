//
//  RestaurantDetailViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-28.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    //Nav Bar
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    
    //Cell one
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisines: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    
    //Cell two
    @IBOutlet weak var lblDetails: UILabel!
    
    //Cell three
    @IBOutlet weak var lblOverallRating: UILabel!
    
    //Cell eight??
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgMap: UIImageView!
    
    
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(selectedRestaurant)
    }
    

}
