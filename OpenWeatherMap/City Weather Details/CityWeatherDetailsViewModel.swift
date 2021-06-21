//
//  CityWeatherDetailsViewModel.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

protocol CityWeatherDetailsCellViewModel { }

protocol CityWeatherDetailsViewModelDelegate: AnyObject {
    func reloadData()
    func showErrorAlert(content: String?)
}

final class CityWeatherDetailsViewModel {
    
    weak var delegate: CityWeatherDetailsViewModelDelegate?
    
    var cellViewModels: [CityWeatherDetailsCellViewModel] = []
    
    private let city: CityListModel
    private let restManager: RestManager = .init()
    
    init(city: CityListModel) {
        self.city = city
    }
    
    func refreshData() {
        let forecastRequest: URLRequest? = RequestManager.createForecastRequest(
            cityId: city.id
        )
        
        guard let safeForecastRequest = forecastRequest else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            
            self.restManager.performRequest(request: safeForecastRequest) { [weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .success(let forecast):
                    self.handleSuccessResponse(forecast: forecast)
                    
                case .failure(let error):
                    self.handleFailureResponse(error: error)
                }
                
                self.handleResponseReceived()
            }
        }
    }
    
    private func handleSuccessResponse(forecast: Forecast) {
        // sorted by days, first values are for today
        var dayWeatherData = calculateDayWeatherData(forecast: forecast)
        
        let todayData = dayWeatherData.removeFirst()
        
        let mainDataCellViewModel: CityWeatherDetailsMainDataCellViewModel = .init(
            cityName: forecast.city?.name,
            dayWeatherData: todayData
        )
        
        cellViewModels.append(mainDataCellViewModel)
        
        dayWeatherData.forEach { data in
            let nextDayDataCellViewModel: CityWeatherDetailsNextDayDataCellViewModel = .init(
                dayWeatherData: data
            )
            
            cellViewModels.append(nextDayDataCellViewModel)
        }
    }
    
    private func handleFailureResponse(error: CustomError?) {
        delegate?.showErrorAlert(content: error?.errorDescription)
    }
    
    private func handleResponseReceived() {
        delegate?.reloadData()
    }
    
    private func calculateDayWeatherData(forecast: Forecast) -> [DayWeatherData] {
        guard let weatherList = forecast.list, !weatherList.isEmpty else { return [] }
        
        let days: [Date] = [
            Date(),
            Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
            Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
        ]
        
        let dayWeatherData: [DayWeatherData] = days.compactMap { day -> DayWeatherData in
            let allDayData = weatherList.filter { Calendar.current.isDate(day, inSameDayAs: Date(timeIntervalSince1970: TimeInterval($0.dt ?? .zero))) }
            
            // 03:00 - 12:00 -> morning
            // 12:01 - 18:00 -> day
            // 18:01 - 02:59 -> night
            
            let morningData = allDayData.filter { data in
                let hour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(data.dt ?? .zero)))
                return hour >= 3 && hour <= 12
            }
            
            let morningTemperatures = morningData.compactMap { $0.main?.temp }
            
            let morningTemperature: Double? = !morningTemperatures.isEmpty
                ? morningTemperatures.reduce(0.0, +) / Double(morningTemperatures.count)
                : nil
            
            let dayData = allDayData.filter { data in
                let hour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(data.dt ?? .zero)))
                return hour > 12 && hour <= 18
            }
            
            let dayTemperatures = dayData.compactMap { $0.main?.temp }
            
            let dayTemperature = !dayTemperatures.isEmpty
                ? dayTemperatures.reduce(0.0, +) / Double(dayTemperatures.count)
                : nil
            
            let nightData = allDayData.filter { data in
                let hour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(data.dt ?? .zero)))
                return hour > 18 || hour < 3
            }
            
            let nightTemperatures = nightData.compactMap { $0.main?.temp }
            
            let nightTemperature = !nightTemperatures.isEmpty
                ? nightTemperatures.reduce(0.0, +) / Double(nightTemperatures.count)
                : nil
            
            var currentTemperature: Double?
            var currentWeather: WeatherDetails?
            let currentHour = Calendar.current.component(.hour, from: Date())
            
            switch currentHour {
            case 3..<12:
                currentTemperature = morningTemperature
                currentWeather = morningData.first?.weather?.first
                
            case 12..<18:
                currentTemperature = dayTemperature
                currentWeather = dayData.first?.weather?.first
                
            default:
                currentTemperature = nightTemperature
                currentWeather = nightData.first?.weather?.first
            }
            
            let minTemperature = allDayData.compactMap { $0.main?.temp_min }.min() ?? .zero
            let maxTemperature = allDayData.compactMap { $0.main?.temp_max }.max() ?? .zero
            
            let temperatures = allDayData.compactMap { $0.main?.temp }
            
            let meanTemperature = !temperatures.isEmpty
                ? temperatures.reduce(0.0, +) / Double(temperatures.count)
                : nil
            
            let humidityValues = allDayData.compactMap { $0.main?.humidity }
            
            let minHumidity = humidityValues.min() ?? .zero
            let maxHumidity = humidityValues.max() ?? .zero
            
            let meanHumidity = !humidityValues.isEmpty
                ? humidityValues.reduce(0, +) / humidityValues.count
                : nil
            
            return .init(
                day: day,
                currentWeather: currentWeather,
                currentTemperature: currentTemperature,
                morningTemperature: morningTemperature,
                dayTemperature: dayTemperature,
                nightTemperature: nightTemperature,
                humidity: meanHumidity,
                minimumTemperature: minTemperature,
                maximumTemperature: maxTemperature,
                meanTemperature: meanTemperature,
                minimumHumidity: minHumidity,
                maximumHumidity: maxHumidity,
                meanHumidity: meanHumidity
            )
        }
        
        return dayWeatherData
    }
}

