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
    
    func queryWeather(cityName: String) {
        let queryUrl = weatherSearchUrl + cityName
        
        sendQueryRequest(url: queryUrl)
    }
    
    private func sendQueryRequest(url: String) {
        // 1, url; 2, session; 3, task; 4, start task
        if let validUrl = URL(string: url) {
            
            let urlSession = URLSession(configuration: .default)
            
            let sessionTask = urlSession.dataTask(with: validUrl, completionHandler: handleRequestCompletion(data:response:err:))
            
            sessionTask.resume()
        }
    }

    private func handleRequestCompletion(data: Data?, response: URLResponse?, err: Error?) {
        if err != nil {
            return
        }
        
        if let validData = data {
            print("xxl-result: \(String(data: validData, encoding: .utf8) ?? "no data")")
        }
        
    }
    
}
