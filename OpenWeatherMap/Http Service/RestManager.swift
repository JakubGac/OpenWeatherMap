//
//  RestManager.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

class RestManager {
    
    private let httpService: HttpService = .init()
    
    deinit {
        httpService.clearURLSession()
    }
    
    func performRequest(request: URLRequest, completionHandler: @escaping (Result<Forecast>) -> Void) {
        httpService.process(request: request) { response in
            guard response.error == nil && (200...300).contains(response.code ?? .zero) else {
                completionHandler(.failure(CustomError.responseError))
                return
            }
            
            guard let responseData = response.data else {
                completionHandler(.failure(CustomError.noDataInResponse))
                return
            }
            
            let decoder: JSONDecoder = .init()
            let decodedForecast = try? decoder.decode(Forecast.self, from: responseData)
            
            guard let safeDecodedForecast = decodedForecast else {
                completionHandler(.failure(CustomError.decodingError))
                return
            }
            
            completionHandler(.success(safeDecodedForecast))
        }
    }
}
