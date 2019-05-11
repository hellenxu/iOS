//
//  RestaurantDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-04-03.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

public class RestaurantDataManager {
    
    private var items:[RestaurantItem] = []
    
    //fetch restaurant items based on cuisines
    public func fetch(by location: String, withFilter: String = "All", completionHandler:(_ items:[RestaurantItem]) -> Void) {
        var restaurants:[RestaurantItem] = []
        
        for restaurant in RestaurantAPIManager.loadJSON(file: location) {
            restaurants.append(RestaurantItem(dict: restaurant))
        }
        
        if withFilter != "All" {
            items = restaurants.filter({$0.cuisines.contains(withFilter)})
        } else {
            items = restaurants
        }
        completionHandler(items)
    }
    
    public func numberOfItems() -> Int {
        return items.count
    }
    
    public func restaurantItem(at index:IndexPath) -> RestaurantItem {
        return items[index.item]
    }
    
    public init() {}
}
