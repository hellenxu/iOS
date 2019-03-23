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
        manager.getRestaurants { (annotations) in
            initMap(annotations)
        }
    }
    
    func initMap(_ annotations: [RestaurantItem]) {
        mapView.setRegion(manager.currentRegion(lat: 0.5, lng: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
}
