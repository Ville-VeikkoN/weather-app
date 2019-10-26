//
//  ForecastData.swift
//  weatherapp
//
//  Created by Ville-Veikko Nieminen on 25/10/2019.
//  Copyright © 2019 Ville-Veikko Nieminen. All rights reserved.
//

import Foundation


struct List: Codable {
    var dt : Int
    var main: Main
    var weather: [Weather]
}

struct ForecastData: Codable {
    var list: [List]
}

