//
//  RestaurantDetailViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-28.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RestaurantDetailViewController: UITableViewController {
    
    //Nav Bar
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    
    //Cell one
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisines: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    
    //Cell two
    @IBOutlet weak var lblTableDetails: UILabel!
    
    //Cell three
    @IBOutlet weak var lblOverallRating: UILabel!
    @IBOutlet weak var ratingView: RatingsView!
    
    //Cell eight??
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgMap: UIImageView!
    
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showReview.rawValue:
                showReview(segue: segue)
            case Segue.showPhotoFilter.rawValue:
                showPhotoFilter(segue: segue)
            default:
                print("Segue not added")
            }
        }
    }
    
    @IBAction func unwindReviewCancel(segue:UIStoryboardSegue) {}

}

private extension RestaurantDetailViewController {
    func initialize() {
        setupLabels()
        createMap()
        createRating()
    }
    
    func showReview(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? ReviewFormViewController else { return }
        
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func showPhotoFilter(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let vc = navController.topViewController as? PhotoFilterViewController else { return }
        
        vc.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    //TODO set rating value dynamically
    func createRating() {
//        ratingView.rating = 3.5
        ratingView.isEnabled = false
    }
    
    func setupLabels() {
        guard let restaurant = selectedRestaurant else {return }
        
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        
        lblCuisines.text = restaurant.cuisines.joined(separator: ",")
        
        if let address = restaurant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedRestaurant, let lng = annotation.long, let lat = annotation.lat else {return}
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        takeSnapShot(with: location)
    }
    
    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start() {snapshot, error in
            guard let snapshot = snapshot else {return }
            
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.imgMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width / 2
                point.y -= pinView.bounds.size.height / 2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
        
    }
}
