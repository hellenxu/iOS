//
//  WeatherResponse.swift
//  Playground
//
//  Created by Hellen on 2021-05-18.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: MainInfo
    let name: String
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct MainInfo: Decodable {
    let temp: Double
}
