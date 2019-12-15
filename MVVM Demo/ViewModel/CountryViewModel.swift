//
//  CountryViewModel.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class CountryViewModel: NSObject {
    private var countryInfo:Country
    
    init(withCountry country:Country){
        self.countryInfo = country
        super.init()
    }
    
    // Add your display logic here
    func getName() -> String{
        return self.countryInfo.name
    }
    
    func getCapital() -> String{
        return self.countryInfo.capital
    }
    
    func getDescription() -> String {
        return "\(self.getName()), \(self.getCapital())"
    }
}
