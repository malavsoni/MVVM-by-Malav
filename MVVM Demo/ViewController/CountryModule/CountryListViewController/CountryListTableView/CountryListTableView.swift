//
//  CountryListTableView.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class CountryListTableView: MSTableView {

    var aryCountryInfo:[CountryViewModel] = []{
        didSet{
            OperationQueue.main.addOperation {
                self.reloadSections(IndexSet.init(integer: 0), with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aryCountryInfo.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReference:CountryListTableViewCell = tableView.dequeueReusableCell()
        cellReference.updateContent(withInfo: self.aryCountryInfo[indexPath.row])
        return cellReference
    }

}
