//
//  HomeViewModel.swift
//  ProjetoGuilda
//
//  Created by Pedro Menezes on 27/10/20.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func error()
    func success()
}

class HomeViewModel {
    
    let provider: HomeProviderDelegate
    weak var delegate: HomeViewModelDelegate?
    
    private var cities: [String] = []
    
    init(provider: HomeProviderDelegate) {
        self.provider = provider
    }
    
    // MARK: - Public methods
    
    func numberOfRows() -> Int {
        return cities.count
    }
    
    func cellContent(for index: Int) -> String {
        guard cities.indices.contains(index) else {
            return ""
        }
        return cities[index]
    }
    
    func callCities(stateNumber: String) {
        provider.getInfos(stateNumber: stateNumber) { (cities) in
            self.cities = cities
            self.delegate?.success()
        } errorCallBack: { (_) in
            self.delegate?.error()
        }
    }
}
