//
//  Response.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import Foundation

struct Response {
    var data: Data?
    var code: Int?
    var error: CustomError?
}
