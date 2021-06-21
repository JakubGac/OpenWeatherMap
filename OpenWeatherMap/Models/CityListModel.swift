//
//  CityListModel.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 21/06/2021.
//

import Foundation

struct CityListModel: Codable {
    var id: Int
    var coord: Coordinations
    var name: String
    var country: String
}
