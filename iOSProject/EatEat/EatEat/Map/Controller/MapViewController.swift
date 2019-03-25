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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initRequest()
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
}
