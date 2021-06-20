//
//  ViewController.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 17/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case Constants.cityWeatherDetailsSegueIdentifier:
            performCityDetailsRedirection(segue)
        
        default: break
        }
    }
    
    private func performCityDetailsRedirection(_ segue: UIStoryboardSegue) {
        guard let nvc = segue.destination as? CityWeatherDetailsViewController else { return }
        
        let viewModel: CityWeatherDetailsViewModel = .init()
        viewModel.delegate = nvc
        
        nvc.viewModel = viewModel
    }
}

extension ViewController {
    enum Constants {
        static let cityWeatherDetailsSegueIdentifier: String = "CityWeatherDetails"
    }
}
