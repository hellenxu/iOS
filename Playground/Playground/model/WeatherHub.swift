//
//  WeatherHub.swift
//  Playground
//
//  Created by Hellen on 2021-05-12.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct WeatherHub{
    private let weatherSearchUrl = "https://api.openweathermap.org/data/2.5/weather?appid=10bea36c7ac4397e6542ac78a1625619&units=metric&q="
    var delegate: WeatherUpdateDelegate?
    
    func queryWeather(cityName: String) {
        let queryUrl = weatherSearchUrl + cityName
        
        sendQueryRequest(url: queryUrl)
    }
    
    mutating func setWeatherDelegate(delegate: WeatherUpdateDelegate) {
        self.delegate = delegate
    }
    
    private func sendQueryRequest(url: String) {
        // 1, url; 2, session; 3, task; 4, start task
        if let validUrl = URL(string: url) {
            
            let urlSession = URLSession(configuration: .default)
            
            let sessionTask = urlSession.dataTask(with: validUrl) { (data, response, err) in
                if err != nil {
                    return
                }
                
                if let validData = data {
                    print("xxl-result: \(String(data: validData, encoding: .utf8) ?? "no data")")
                    if let result = parseData(data: validData) {
                        self.delegate?.onWeatherUpdated(weather: result)
                    }
                }
                
            }
            
            sessionTask.resume()
        }
    }
    
    private func parseData(data: Data) -> WeatherUIModel? {
        let decoder = JSONDecoder()
        do {
            let decodedInfo = try decoder.decode(WeatherResponse.self, from: data)
            let uiInfo = WeatherUIModel(temperature: decodedInfo.main.temp, conditionId: decodedInfo.weather[0].id, cityName: decodedInfo.name)
            return uiInfo
        } catch {
            print("xxl-error: \(String(describing: error))")
            return nil
        }
    }
}

protocol WeatherUpdateDelegate {
    func onWeatherUpdated(weather: WeatherUIModel)
}
