//
//  RestaurantPhotoItem.swift
//  EatEat
//
//  Created by Hellen on 2019-04-20.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

struct RestaurantPhotoItem {
    var photo: UIImage?
    var date: Date?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    
    var photoData: NSData {
        guard let image = photo else { return NSData() }
        
        return NSData(data: image.pngData()!)
    }
}

extension RestaurantPhotoItem {
    init(data: RestaurantPhoto) {
        self.restaurantID = Int(data.restaurantID)
        if let restaurantPhoto = data.photo {
            self.photo = UIImage(data: restaurantPhoto, scale: 1.0)
        }
        if let uuid = data.uuid {self.uuid = uuid}
        if let reviewDate = data.date {self.date = reviewDate}
    }
}
