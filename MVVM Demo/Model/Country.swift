//
//  Country.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

struct Country:Codable {
    var name:String
    var capital:String
    
    init(withName name:String,andCapital capital:String) {
        self.name = name
        self.capital = capital
    }
     
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.capital, forKey: .capital)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.capital = try container.decode(String.self, forKey: .capital)
    }
        
    enum CodingKeys:String,CodingKey {
        case name
        case capital
    }
}
