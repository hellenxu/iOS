//
//  RestaurantItem.swift
//  EatEat
//
//  Created by Hellen on 2019-03-22.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import MapKit

public class RestaurantItem: NSObject, MKAnnotation {

    public var title: String? {
        return name
    }
    
    public var subtitle: String? {
        if cuisines.isEmpty {
            return ""
        } else if cuisines.count == 1 {
            return cuisines.first
        } else {
            return cuisines.joined(separator: ", ")
        }
    }
    
    public var coordinate: CLLocationCoordinate2D {
        guard let lat = lat, let long = long else { return CLLocationCoordinate2D() }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    public enum CodingKeys: String {
        case name
        case cuisines
        case lat
        case long
        case address
        case postalCode = "postal_code"
        case state
        case imageURL = "image_url"
        case restaurantID = "id"
    }
    
    public var name: String?
    public var cuisines: [String] = []
    public var lat: Double?
    public var long: Double?
    public var address: String?
    public var postalCode: String?
    public var state: String?
    public var imageURL: String?
    public var restaurantID: Int?

    init(dict: [String:AnyObject]) {
        if let name = dict["name"] as? String { self.name = name}
        if let cuisines = dict["cuisines"] as? [String] { self.cuisines = cuisines}
        if let lat = dict["lat"] as? Double { self.lat = lat}
        if let long = dict["long"] as? Double { self.long = long}
        if let address = dict["address"] as? String { self.address = address}
        if let postalCode = dict["postal_code"] as? String { self.postalCode = postalCode}
        if let state = dict["state"] as? String { self.state = state}
        if let image = dict["image_url"] as? String { self.imageURL = image}
        if let id = dict["id"] as? Int {self.restaurantID = id}
    }
}
