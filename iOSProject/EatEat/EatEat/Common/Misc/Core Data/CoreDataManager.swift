//
//  CoreDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-04-20.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    let container: NSPersistentContainer
    
    override init() {
        container = NSPersistentContainer(name: "EatModel")
        container.loadPersistentStores{(storeDesc, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
        }
        super.init()
    }
    
    func fetchRestaurantRating(by identifier: Int) -> Float {
        let reviews = fetchReviews(by: identifier)
        let sum = reviews.reduce(0, {$0 + ($1.rating ?? 0)})
        return sum / Float(reviews.count)
    }
    
    func fetchReviews(by identifier: Int) -> [ReviewItem] {
        let moc = container.viewContext
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(identifier))
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        var items: [ReviewItem] = []
        do {
            for data in try moc.fetch(request) {
                items.append(ReviewItem(data: data))
            }
            return items
        } catch {
            fatalError("Failed to fetch reviews: (error)")
        }
    }
    
    func addReview(_ item: ReviewItem) {
        let review = Review(context: container.viewContext)
        review.name = item.name
        review.title = item.title
        review.date = item.date
        review.customerReview = item.customerReview
        review.uuid = item.uuid
        if let rating = item.rating {review.rating = rating}
        if let id = item.restaurantID {
            review.restaurantID = Int32(id)
            print("review - restaurant id (id)")
            save()
        }
    }
    
    func fetchPhotos(by identifier: Int) -> [RestaurantPhotoItem] {
        let moc = container.viewContext
        let request: NSFetchRequest<RestaurantPhoto> = RestaurantPhoto.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(identifier))
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        var items: [RestaurantPhotoItem] = []
        do {
            for data in try moc.fetch(request) {
                items.append(RestaurantPhotoItem(data: data))
            }
            return items
        } catch {
            fatalError("Failed to fetch photo items: (error)")
        }
    }
    
    func addPhoto(_ item: RestaurantPhotoItem) {
        let photo = RestaurantPhoto(context: container.viewContext)
        photo.date = Date()
        photo.photo = Data(item.photoData)
        photo.uuid = item.uuid
        
        if let id = item.restaurantID {
            photo.restaurantID = Int32(id)
            print("photo - restaurant id (id)")
            save()
        }
    }
    
    fileprivate func save() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
