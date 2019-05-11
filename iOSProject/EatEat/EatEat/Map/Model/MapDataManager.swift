//
//  MapDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-22.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation
import MapKit
import EatDataKit

class MapDataManager: DataManager {

    fileprivate var items: [RestaurantItem] = []
    var annotations: [RestaurantItem] {
        return items
    }
    
    func getRestaurants(completion: (_ annotations: [RestaurantItem]) -> ()) {
        
        //TODO replace hard coded parameter "Boston"
        let manager = RestaurantDataManager()
        manager.fetch(by: "Boston", completionHandler: {(items) in
            self.items = items
            completion(items)
        })
    }
    
    func currentRegion(lat: CLLocationDegrees, lng: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else { return MKCoordinateRegion() }
        let span = MKCoordinateSpan(latitudeDelta: lat, longitudeDelta: lng)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}
