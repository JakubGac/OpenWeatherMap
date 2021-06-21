//
//  CityWeatherDetailsViewController.swift
//  OpenWeatherMap
//
//  Created by Jakub Gac on 20/06/2021.
//

import UIKit

final class CityWeatherDetailsViewController: UITableViewController {
    
    var viewModel: CityWeatherDetailsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDelegate
extension CityWeatherDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        
        switch cellViewModel {
        case is CityWeatherDetailsMainDataCellViewModel:
            if let mainDataCell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherDetailsMainDataCellIdentifier", for: indexPath) as? CityWeatherDetailsMainDataCellView {
                mainDataCell.viewModel = cellViewModel as? CityWeatherDetailsMainDataCellViewModel
                return mainDataCell
            }
            
        case is CityWeatherDetailsNextDayDataCellViewModel:
            if let nextDayDataCell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherDetailsNextDayDataCellIdentifier", for: indexPath) as? CityWeatherDetailsNextDayDataCellView {
                nextDayDataCell.viewModel = cellViewModel as? CityWeatherDetailsNextDayDataCellViewModel
                return nextDayDataCell
            }
        
        default: break
        }
        
        return .init()
    }
}

// MARK: - CityWeatherDetailsViewModelDelegate
extension CityWeatherDetailsViewController: CityWeatherDetailsViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showErrorAlert(content: String?) {
        let alertAction: (UIAlertAction) -> Void = { [weak self] _ in
            guard let `self` = self else { return }
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let alert: UIAlertController = AlertUtils.createErrorAlert(
            title: "Error",
            message: content,
            action: alertAction
        )
        
        present(alert, animated: true, completion: nil)
    }
}
