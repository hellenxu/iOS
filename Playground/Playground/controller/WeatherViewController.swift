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
    
    var weatherHub = WeatherHub()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherHub.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func onLocationClicked(_ sender: UIButton) {
    }
    
    @IBAction func onSearchClicked(_ sender: UIButton) {
        if searchTextField.text?.isEmpty == true {
            return
        }
        
        weatherHub.queryWeather(searchTextField.text ?? "Toronto")
    }
    
}


extension WeatherViewController: WeatherUpdateDelegate {
    func onWeatherUpdated(weather: WeatherUIModel) {
        print("xxl-updated: \(weather.cityName); \(Thread.current.isMainThread)")
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionImageName)
        }
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please input a city name."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherHub.queryWeather(city)
        }
        
        textField.text = ""
    }
}
