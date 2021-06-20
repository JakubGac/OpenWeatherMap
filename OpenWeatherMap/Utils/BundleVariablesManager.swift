//
//  BundleVariablesManager.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

final class BundleVariablesManager {
    
    static func getApiKey() -> String {
        return Bundle.main.infoDictionary![Constants.apiKey] as! String
    }
    
}

extension BundleVariablesManager {
    enum Constants {
        static let apiKey = "API_KEY"
    }
}
