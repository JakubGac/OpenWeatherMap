//
//  CityWeatherDetailsMainDataCellView.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import UIKit

final class CityWeatherDetailsMainDataCellView: UITableViewCell {
        
    @IBOutlet weak var baseInfoLabel: UILabel!
    @IBOutlet weak var detailsInfoLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    
    weak var viewModel: CityWeatherDetailsMainDataCellViewModel? {
        didSet {
            setCell()
        }
    }
    
    private func setCell() {
        currentWeatherImageView.image = viewModel?.currentWeatherImage
        
        baseInfoLabel.attributedText = createBaseInfoMutableString()
        detailsInfoLabel.attributedText = createDetailsAttributedString()
    }
    
    private func createBaseInfoMutableString() -> NSMutableAttributedString {
        let mutableString: NSMutableAttributedString = .init()
        
        mutableString.append(
            .init(
                string: viewModel?.cityName ?? "",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 35.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        mutableString.append(
            .init(
                string: viewModel?.currentTemperature ?? "",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 45.0, weight: .bold),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        mutableString.append(
            .init(
                string: String(format: "Wilgotność: %@", viewModel?.humidity ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 30.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n\n"))
        
        mutableString.append(
            .init(
                
                string: String(format: "Temp rano: %@\nTemp w ciągu dnia: %@\nTemp w nocy: %@", viewModel?.morningTemperature ?? "", viewModel?.dayTemperature ?? "", viewModel?.nightTemperature ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 20.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
                
        return mutableString
    }
    
    private func createDetailsAttributedString() -> NSMutableAttributedString {
        let mutableString: NSMutableAttributedString = .init()
        
        mutableString.append(
            .init(
                string: String(format: "Temp min: %@    Temp max: %@    Temp średnia: %@", viewModel?.minimumTemperature ?? "", viewModel?.maximumTemperature ?? "", viewModel?.meanTemperature ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n\n"))
        
        mutableString.append(
            .init(
                string: String(format: "Wilgotność min: %@    Wilgotność max: %@    Wilgotność średnia: %@", viewModel?.minimumHumidity ?? "", viewModel?.maximumumidity ?? "", viewModel?.meanHumidity ?? ""),
                attributes: [
                    .font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                    .foregroundColor: UIColor.white,
                ]
            )
        )
        
        mutableString.append(.init(string: "\n"))
        
        return mutableString
    }
}
