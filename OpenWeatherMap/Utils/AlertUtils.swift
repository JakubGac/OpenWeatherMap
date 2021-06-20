//
//  AlertUtils.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import UIKit

final class AlertUtils {
    
    static func createErrorAlert(title: String?, message: String?, action: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert: UIAlertController = .init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction: UIAlertAction = .init(
            title: "OK",
            style: .default,
            handler: action
        )
        alert.addAction(okAction)
        
        return alert
    }
}
