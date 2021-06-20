//
//  Forecast.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

struct Forecast: Codable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [Weather]?
    var city: City?
}
