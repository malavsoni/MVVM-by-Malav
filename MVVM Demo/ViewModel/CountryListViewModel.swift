//
//  CountryListViewModel.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

protocol CountryListViewModelProtocol:class {
    func didReceive(countries aryCountries:[CountryViewModel]) -> Void
    func failedToGetCountries(withError error:Error) -> Void
}

class CountryListViewModel: NSObject {
    
    weak private var delegate:CountryListViewModelProtocol?
    
    init(withDelegate delegate:CountryListViewModelProtocol){
        self.delegate = delegate
    }
    
    func fetchCountries() -> Void{
        MSServiceManager.shared.getCountryList {[weak self] (aryCountry, error) in
            if let error = error{
                self?.delegate?.failedToGetCountries(withError: error)
            }else{
                var aryCountryViewModel:[CountryViewModel] = []
                for country in aryCountry{
                    aryCountryViewModel.append(CountryViewModel.init(withCountry: country))
                }
                self?.delegate?.didReceive(countries: aryCountryViewModel)
            }
        }
    }
}
