//
//  WeatherViewController.swift
//  Playground
//
//  Created by Hellen on 2021-05-12.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, WeatherUpdateDelegate {
    
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherHub = WeatherHub()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherHub.delegate = self
    }
    
    @IBAction func onLocationClicked(_ sender: UIButton) {
    }
    
    @IBAction func onSearchClicked(_ sender: UIButton) {
        if searchTextField.text?.isEmpty == true {
            return
        }
        
        weatherHub.queryWeather(cityName: searchTextField.text ?? "Toronto")
    }
    
    func onWeatherUpdated(weather: WeatherUIModel) {
        print("xxl-updated: \(weather.cityName); \(Thread.current.isMainThread)")
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionImageName)
        }
    }
}
