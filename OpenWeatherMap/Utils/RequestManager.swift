//
//  RequestManager.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

final class RequestManager {
    
    private static let apiKey: String = BundleVariablesManager.getApiKey()
    
    static func createForecastRequest(cityId: Int) -> URLRequest? {
        var urlComponents: URLComponents = .init()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.forecastPath
        urlComponents.queryItems = [
            .init(
                name: Constants.cityIDQueryName,
                value: String(format: "%d", cityId)
            ),
            .init(
                name: Constants.languageQueryName,
                value: "pl"
            ),
            .init(
                name: Constants.unitsQueryName,
                value: "metric"
            ),
            .init(
                name: Constants.appIDQueryName,
                value: apiKey
            )
        ]
        
        guard let url = urlComponents.url else { return nil }
        
        return .init(url: url)
    }
    
}

extension RequestManager {
    enum Constants {
        static let scheme: String = "https"
        static let host: String = "api.openweathermap.org"
        static let forecastPath: String = "/data/2.5/forecast"
        static let cityIDQueryName: String = "id"
        static let languageQueryName: String = "lang"
        static let unitsQueryName: String = "units"
        static let appIDQueryName: String = "appid"
    }
}
