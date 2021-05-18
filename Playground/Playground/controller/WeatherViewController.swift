//
//  WeatherViewController.swift
//  Playground
//
//  Created by Hellen on 2021-05-12.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let weatherHub = WeatherHub()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onLocationClicked(_ sender: UIButton) {
    }
    
    @IBAction func onSearchClicked(_ sender: UIButton) {
        if searchTextField.text?.isEmpty == true {
            return
        }
        
        weatherHub.queryWeather(cityName: searchTextField.text ?? "Toronto")
    }
    
}
