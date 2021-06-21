//
//  DayWeatherData.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 21/06/2021.
//

import Foundation

struct DayWeatherData {
    var day: Date
    var currentWeather: WeatherDetails?
    var currentTemperature: Double?
    var morningTemperature: Double?
    var dayTemperature: Double?
    var nightTemperature: Double?
    var humidity: Int?
    var minimumTemperature: Double
    var maximumTemperature: Double
    var meanTemperature: Double?
    var minimumHumidity: Int
    var maximumHumidity: Int
    var meanHumidity: Int?
}
