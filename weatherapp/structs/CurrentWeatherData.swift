//
//  CurrentWeatherData.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 22/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
}

struct CurrentWeatherData: Codable {
    var weather: [Weather]
    var main: Main
}
