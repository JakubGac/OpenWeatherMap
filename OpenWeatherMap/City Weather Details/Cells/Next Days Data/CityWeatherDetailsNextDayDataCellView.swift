//
//  CityWeatherDetailsNextDayDataCellView.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 21/06/2021.
//

import UIKit

final class CityWeatherDetailsNextDayDataCellView: UITableViewCell {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    weak var viewModel: CityWeatherDetailsNextDayDataCellViewModel? {
        didSet {
            setCell()
        }
    }
    
    private func setCell() {
        infoLabel.attributedText = createInfoMutableString()
    }
    
    private func createInfoMutableString() -> NSMutableAttributedString {
        let mutableString: NSMutableAttributedString = .init()
        
        mutableString.append(
            .init(
                string: String(format: "%@", viewModel?.dayName ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 20.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        mutableString.append(
            .init(
                string: String(format: "Temp rano: %@\nTemp w ciągu dnia: %@\nTemp w nocy: %@", viewModel?.morningTemperature ?? "", viewModel?.dayTemperature ?? "", viewModel?.nightTemperature ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        mutableString.append(
            .init(
                string: String(format: "Temp min: %@    Temp max: %@    Temp średnia: %@", viewModel?.minimumTemperature ?? "", viewModel?.maximumTemperature ?? "", viewModel?.meanTemperature ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 10.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        mutableString.append(
            .init(
                string: String(format: "Wilgotność min: %@    Wilgotność max: %@    Wilgotność średnia: %@", viewModel?.minimumHumidity ?? "", viewModel?.maximumumidity ?? "", viewModel?.meanHumidity ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 10.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        return mutableString
    }
    
}
