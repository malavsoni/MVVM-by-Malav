//
//  CountryListViewController.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class CountryListViewController: SuperViewController {
    
    @IBOutlet weak var tblReference: CountryListTableView!
    var viewModel:CountryListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = CountryListViewModel.init(withDelegate: self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel?.fetchCountries()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CountryListViewController : CountryListViewModelProtocol{
    func didReceive(countries aryCountries: [CountryViewModel]) {
        self.tblReference.aryCountryInfo = aryCountries
    }
    
    func failedToGetCountries(withError error: Error) {
        
    }
    
    
}
