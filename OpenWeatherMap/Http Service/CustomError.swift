//
//  CustomError.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

enum CustomError: Error {
    case decodingError
    case noDataInResponse
}
