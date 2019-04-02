//
//  LocationDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-21.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class LocationDataManager: DataManager {
    
    private var locations: [LocationItem] = []
    
    func fetch() {
        for loc in load(file: "Locations") {
            locations.append(LocationItem(dict: loc))
        }
    }
    
    func countOfLocations () -> Int {
        return locations.count
    }
    
    func getLoc(at index: IndexPath) -> LocationItem {
        return locations[index.item]
    }
    
    func searchLocation(by name: String) -> (isFound: Bool, position: Int) {
        guard let index = locations.index(where: {$0.city == name}) else { return (isFound: false, position: 0) }
        return (isFound:true, position: index)
    }
    
}
