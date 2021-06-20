//
//  WeatherDetails.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

struct WeatherDetails: Codable {
    var id: Int
    var main: String?
    var description: String?
    var icon: String?
}
