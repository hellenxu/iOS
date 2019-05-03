//
//  LocationViewController.swift
//  EatEat
//
//  Created by Hellen on 2019-03-21.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let locManager = LocationDataManager()
    var selectedCity: LocationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func set(selected cell: UITableViewCell, at indexPath: IndexPath) {
        if let city = selectedCity?.city {
            let data = locManager.searchLocation(by: city)
            
            if data.isFound {
                if indexPath.row == data.position {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
        } else {
            cell.accessoryType = .none
        }
    }
}

//MARK: private extension
private extension LocationViewController {
    
    func initialize() {
        locManager.fetch()
        title = "Select a Location"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

//MARK: UITableViewDataSource
extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locManager.countOfLocations()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = locManager.getLoc(at: indexPath).full
        set(selected: cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedCity = locManager.getLoc(at: indexPath)
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
