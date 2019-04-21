//
//  ReviewItem.swift
//  EatEat
//
//  Created by Hellen on 2019-04-20.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

struct ReviewItem {
    var rating: Float?
    var name: String?
    var title: String?
    var customerReview: String?
    var date: Date?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        guard let reviewDate = date else {return ""}
        return formatter.string(from: reviewDate)
    }
}

extension ReviewItem {
    init(data: Review) {
        if let reviewDate = data.date {self.date = reviewDate}
        self.rating = data.rating
        self.name = data.name
        self.title = data.title
        self.customerReview = data.customerReview
        self.restaurantID = Int(data.restaurantID)
        if let uuid = data.uuid {self.uuid = uuid}
    }
}
