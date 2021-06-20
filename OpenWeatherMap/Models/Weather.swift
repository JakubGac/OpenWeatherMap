//
//  Weather.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

struct Weather: Codable {
    var dt: Int?
    var main: MainWeatherData?
    var weather: [WeatherDetails]?
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var sys: PartOfDay?
    var dt_txt: String?
}
