//
//  RestaurantDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-04-03.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class RestaurantDataManager {
    
    private var items:[RestaurantItem] = []
    
    //fetch restaurant items based on cuisines
    func fetch(by location: String, withFilter: String = "All", completionHandler:() -> Void) {
        var restaurants:[RestaurantItem] = []
        
        for restaurant in RestaurantAPIManager.loadJSON(file: location) {
            restaurants.append(RestaurantItem(dict: restaurant))
        }
        
        if withFilter != "All" {
            items = restaurants.filter({$0.cuisines.contains(withFilter)})
        } else {
            items = restaurants
        }
        completionHandler()
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func restaurantItem(at index:IndexPath) -> RestaurantItem {
        return items[index.item]
    }
}
