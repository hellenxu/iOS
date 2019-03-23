//
//  MapDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-22.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation
import MapKit

class MapDataManager: DataManager {

    fileprivate var items: [RestaurantItem] = []
    var annotations: [RestaurantItem] {
        return items
    }
    
    func getRestaurants(completion: (_ annotations: [RestaurantItem]) -> ()) {
        if items.count > 0 { items.removeAll() }
        
        for data in load(file: "MapLocations") {
            items.append(RestaurantItem(dict: data))
        }
        
        completion(items)
    }
    
    func currentRegion(lat: CLLocationDegrees, lng: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = items.first else { return MKCoordinateRegion() }
        let span = MKCoordinateSpan(latitudeDelta: lat, longitudeDelta: lng)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}
