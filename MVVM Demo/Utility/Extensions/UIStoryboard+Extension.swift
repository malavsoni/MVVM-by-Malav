//
//  UIStoryboard+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 09/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

enum MSStoryboard:String {
    case loginAndSignUp = "LoginAndSignupModule"
    case country = "CountryModule"
}

extension UIStoryboard{
    class func getViewController(withIdentifier identifier:String, fromStoryboard storyboardType:MSStoryboard) -> UIViewController{
        let storyboard = UIStoryboard.init(name: storyboardType.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
