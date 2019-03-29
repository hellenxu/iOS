//
//  MapViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-22.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    let manager = MapDataManager()
    var selectedRestaurant: RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initRequest()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(inSegue: segue)
        default:
            print("Segue not added")
        }
    }
    
    func showRestaurantDetail(inSegue: UIStoryboardSegue) {
        if let viewController = inSegue.destination as? RestaurantDetailViewController,
        let restaurant = selectedRestaurant {
            viewController.selectedRestaurant = restaurant
        }
    }
    
    func initRequest() {
        mapView.delegate = self
        
        manager.getRestaurants { (annotations) in
            initMap(annotations)
        }
    }
    
    func initMap(_ annotations: [RestaurantItem]) {
        mapView.setRegion(manager.currentRegion(lat: 0.5, lng: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        guard !annotation.isKind(of: MKUserLocation.self) else {return nil}
        var annotationView: MKAnnotationView?
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "custom-annotation")
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else { return }
        selectedRestaurant = annotation as? RestaurantItem
        
        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
}
