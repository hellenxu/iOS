//
//  LocationItem.swift
//  EatEat
//
//  Created by Hellen on 2019-03-31.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

struct LocationItem {
    var state: String?
    var city: String?
}

extension LocationItem {
    init(dict: [String:AnyObject]) {
        self.state = dict["state"] as? String
        self.city = dict["city"] as? String
    }
    
    var full : String {
        guard let city = self.city, let state = self.state else { return "" }
        return "\(city), \(state)"
    }
    
}
