//
//  CustomError.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

enum CustomError: Error {
    case responseError
    case decodingError
    case noDataInResponse
    
    var errorDescription: String {
        switch self {
        case .decodingError: return "Decoding Error"
        case .noDataInResponse: return "Response is empty"
        case .responseError: return "Something went wrong. Try again later!"
        }
    }
}
