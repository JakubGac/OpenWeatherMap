//
//  CitySelectionViewModel.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 21/06/2021.
//

import Foundation

final class CitySelectionViewModel {
    
    var selectedCityPickerModel: CityListModel?
    var citiesPickerModels: [CityPickerModel] = []
    
    private var citiesList: [CityListModel] = []
    
    init() {
        readCityList()
    }
    
    private func readCityList() {
        let filePath = BundleVariablesManager.getCitiesListFilePath()
        
        let url: URL = .init(fileURLWithPath: filePath)
        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else { return }
        
        let decoder: JSONDecoder = .init()
        let decodedData = try? decoder.decode([CityListModel].self, from: data)
        
        // MARK: should handle lack of cities situation
        guard let safeDecodedData = decodedData else { return }
        
        citiesList = safeDecodedData
        
        // MARK: get 5 random cities
        var randomlySelectedCities: [CityListModel] = []
        for _ in 1...5 {
            if let randomElement = safeDecodedData.randomElement() {
                randomlySelectedCities.append(randomElement)
            }
        }
        
        citiesPickerModels = randomlySelectedCities.compactMap {
            .init(id: $0.id, name: $0.name)
        }
        
        // MARK: by default first row is selected
        selectedCityPickerModel = citiesList.first(where: { $0.id == citiesPickerModels.first?.id })
    }
    
    func handleCitySelection(_ row: Int) {
        let selectedPickerModel = citiesPickerModels[row]
        selectedCityPickerModel = citiesList.first(where: { $0.id == selectedPickerModel.id })
    }
}

