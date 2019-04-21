//
//  ReviewDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-04-20.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class ReviewDataManager: NSObject {
    private var reviewItems: [ReviewItem] = []
    private var photoItems: [RestaurantPhotoItem] = []
    let manager = CoreDataManager()
    
    func fetchReviews(by restaurantID: Int) {
        if reviewItems.count > 0 {reviewItems.removeAll()}
        
        for data in manager.fetchReviews(by: restaurantID) {
            reviewItems.append(data)
        }
    }
    
    func fetchPhoto(by restaurantID: Int) {
        if photoItems.count > 0 {photoItems.removeAll()}
        
        for data in manager.fetchPhotos(by: restaurantID) {
            photoItems.append(data)
        }
    }
    
    func countOfReviews() -> Int {
        return reviewItems.count
    }
    
    func countOfPhotos() -> Int {
        return photoItems.count
    }
    
    func getReviewItem(at index: IndexPath) -> ReviewItem {
        return reviewItems[index.item]
    }
    
    func getPhotoItem(at index: IndexPath) -> RestaurantPhotoItem {
        return photoItems[index.item]
    }
}
