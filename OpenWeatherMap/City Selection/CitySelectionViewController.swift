//
//  CitySelectionViewController.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 21/06/2021.
//

import UIKit

class CitySelectionViewController: UIViewController {
    
    let viewModel: CitySelectionViewModel = .init()
    
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var showWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case Constants.cityWeatherDetailsSegueIdentifier:
            performCityDetailsRedirection(segue)
        
        default: break
        }
    }
    
    private func setupView() {
        cityPicker.delegate = self
        
        showWeatherButton.layer.borderWidth = 1
        showWeatherButton.backgroundColor = .clear
        showWeatherButton.layer.borderColor = UIColor.white.cgColor
        showWeatherButton.layer.cornerRadius = showWeatherButton.frame.height / 2
    }
    
    private func performCityDetailsRedirection(_ segue: UIStoryboardSegue) {
        guard let nvc = segue.destination as? CityWeatherDetailsViewController,
              let selectedCityModel = viewModel.selectedCityPickerModel else { return }
        
        let viewModel: CityWeatherDetailsViewModel = .init(city: selectedCityModel)
        viewModel.delegate = nvc
        
        nvc.viewModel = viewModel
    }
}

extension CitySelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.handleCitySelection(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.citiesPickerModels[row].name
    }
}

extension CitySelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.citiesPickerModels.count
    }
}

extension CitySelectionViewController {
    enum Constants {
        static let cityWeatherDetailsSegueIdentifier: String = "CityWeatherDetails"
    }
}
