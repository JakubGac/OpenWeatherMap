//
//  Result.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error?)
}
