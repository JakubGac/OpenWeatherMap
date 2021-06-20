//
//  CityWeatherDetailsMainDataCellViewModel.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

final class CityWeatherDetailsMainDataCellViewModel: CityWeatherDetailsCellViewModel {
    
    let cityName: String?
    
    var morningTemperature: String {
        return String(format: "%.0f°", dayWeatherData.morningTemperature)
    }
    
    var dayTemperature: String {
        return String(format: "%.0f°", dayWeatherData.dayTemperature)
    }
    
    var nightTemperature: String {
        return String(format: "%.0f°", dayWeatherData.nightTemperature)
    }
    
    var minimumTemperature: String {
        return String(format: "%.0f°", dayWeatherData.minimumTemperature)
    }
    
    var maximumTemperature: String {
        return String(format: "%.0f°", dayWeatherData.maximumTemperature)
    }
    
    var meanTemperature: String {
        return String(format: "%.0f°", dayWeatherData.meanTemperature)
    }
    
    var humidity: String {
        return String(format: "%d", dayWeatherData.humidity)
    }
    
    var minimumHumidity: String {
        return String(format: "%d", dayWeatherData.minimumHumidity)
    }
    
    var maximumumidity: String {
        return String(format: "%d", dayWeatherData.maximumHumidity)
    }
    
    var meanHumidity: String {
        return String(format: "%d", dayWeatherData.meanHumidity)
    }
    
    private let dayWeatherData: DayWeatherData
    
    init(cityName: String?, dayWeatherData: DayWeatherData) {
        self.cityName = cityName
        self.dayWeatherData = dayWeatherData
    }
}
