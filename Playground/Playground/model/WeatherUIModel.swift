//
//  WeatherUIModel.swift
//  Playground
//
//  Created by Hellen on 2021-05-18.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct WeatherUIModel{
    let temperature: Double
    let conditionId: Int
    
    let cityName: String
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionImageName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
