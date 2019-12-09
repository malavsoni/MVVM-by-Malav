//
//  CountryListTableViewCell.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCountryName: MSLabel!
    @IBOutlet weak var lblCapital: MSLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateContent(withInfo countryInfo:CountryViewModel) -> Void{
        self.lblCountryName.text = countryInfo.getName()
        self.lblCapital.text = countryInfo.getCapital()
    }
}
