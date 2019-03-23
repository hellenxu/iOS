//
//  LocationDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-21.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class LocationDataManager: DataManager {
    
    private var locations: [String] = []
    
    func fetch() {
        for loc in load(file: "Locations") {
            if let city = loc["city"] as? String,
                let state = loc["state"] as? String {
                locations.append("\(city), \(state)")
            }
        }
    }
    
    func countOfLocations () -> Int {
        return locations.count
    }
    
    func getLoc(at index: IndexPath) -> String {
        return locations[index.item]
    }
    
}
