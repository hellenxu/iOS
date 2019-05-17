//
//  RestaurantDetailViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-28.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation
import MapKit
import EatDataKit

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
    let coreManager = CoreDataManager()
    
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

    @IBAction func onTimeTapped(sender: UIButton) {
        showNotification(sender: sender.titleLabel?.text)
    }
}

private extension RestaurantDetailViewController {
    func initialize() {
        setupLabels()
        createMap()
        createRating()
        setupNotificationDefaults()
    }
    
    func setupNotificationDefaults() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    func showNotification(sender: String?) {
        let content = UNMutableNotificationContent()
        if let name = selectedRestaurant?.name {
            content.title = name
        }
        if let time = sender {
            content.body = "Table for 2, tonight at \(time)"
        }
        content.subtitle = "Restaurant Reservation"
        content.badge = 1
        content.categoryIdentifier = Identifier.reservationCategory.rawValue
        if let id = selectedRestaurant?.restaurantID {
            content.threadIdentifier = "\(id)"
            print("xxl-id: \(id)")
        }
        if let restaurantName = selectedRestaurant?.name {
            content.summaryArgument = restaurantName
            print("xxl-name: \(restaurantName)")
        }
        guard let imgURL = Bundle.main.url(forResource: "sample-restaurant-img@3x", withExtension: "png") else {return }
        let attachment = try! UNNotificationAttachment(identifier: "EatEatReservation", url: imgURL, options: nil)
        content.attachments = [attachment]
        sendNotification(with: content)
    }
    
    func sendNotification(with content: UNNotificationContent) {
        let uuid = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func showReview(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? ReviewFormViewController else { return }
        
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func showPhotoFilter(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let vc = navController.topViewController as? PhotoFilterViewController else { return }
        
        vc.selectedRestaurantID = selectedRestaurant?.restaurantID
    }
    
    func createRating() {
        if let id = selectedRestaurant?.restaurantID {
            let value = formatRating(raw: coreManager.fetchRestaurantRating(by: id))
            ratingView.rating = CGFloat(value)
            if ratingView.rating.isNaN {lblOverallRating.text = "0"}
            else {lblOverallRating.text = "\(value)"}
        }
        ratingView.isEnabled = false
    }
    
    func formatRating(raw: Float) -> Float {
        var value: Float
        if (raw + 0.5 < ceilf(Float(raw))) {
            value = floor(raw) + 0.5
        } else {
            value = ceilf(Float(raw))
        }
        
        return min(max(value, 0), Float(ratingView.totalStars))
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

//MARKER: notification delegate
extension RestaurantDetailViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let identifier = Option(rawValue: response.actionIdentifier) {
            switch identifier {
            case .one:
                print("User selected yes")
            case .two:
                print("User selected no")
            }
        }
        completionHandler()
    }
}
