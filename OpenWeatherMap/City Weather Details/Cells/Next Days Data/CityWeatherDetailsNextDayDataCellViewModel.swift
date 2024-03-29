//
//  CityWeatherDetailsNextDayDataCellViewModel.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 21/06/2021.
//

import Foundation

final class CityWeatherDetailsNextDayDataCellViewModel: CityWeatherDetailsCellViewModel {
    
    var dayName: String {
        let dateFormatter: DateFormatter = .init()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = .init(identifier: "pl")
        return dateFormatter.string(from: dayWeatherData.day).capitalized
    }
    
    var morningTemperature: String {
        if let morningTemperature = dayWeatherData.morningTemperature {
            return String(format: "%.0f°", morningTemperature)
        } else {
            return "-"
        }
    }
    
    var dayTemperature: String {
        if let dayTemperature = dayWeatherData.dayTemperature {
            return String(format: "%.0f°", dayTemperature)
        } else {
            return "-"
        }
    }
    
    var nightTemperature: String {
        if let nightTemperature = dayWeatherData.nightTemperature {
            return String(format: "%.0f°", nightTemperature)
        } else {
            return "-"
        }
    }
    
    var minimumTemperature: String {
        return String(format: "%.0f°", dayWeatherData.minimumTemperature)
    }
    
    var maximumTemperature: String {
        return String(format: "%.0f°", dayWeatherData.maximumTemperature)
    }
    
    var meanTemperature: String {
        if let meanTemperature = dayWeatherData.meanTemperature {
            return String(format: "%.0f°", meanTemperature)
        } else {
            return "-"
        }
    }
    
    var humidity: String {
        if let humidity = dayWeatherData.humidity {
            return String(format: "%d%%", humidity)
        } else {
            return "-"
        }
    }
    
    var minimumHumidity: String {
        return String(format: "%d%%", dayWeatherData.minimumHumidity)
    }
    
    var maximumumidity: String {
        return String(format: "%d%%", dayWeatherData.maximumHumidity)
    }
    
    var meanHumidity: String {
        if let meanHumidity = dayWeatherData.meanHumidity {
            return String(format: "%d%%", meanHumidity)
        } else {
            return "Brak danych"
        }
    }
    
    private let dayWeatherData: DayWeatherData
    
    init(dayWeatherData: DayWeatherData) {
        self.dayWeatherData = dayWeatherData
    }
}
