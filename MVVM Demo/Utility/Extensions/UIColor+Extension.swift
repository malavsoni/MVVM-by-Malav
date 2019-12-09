//
//  UIColor+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 12/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension UIColor{
    class var appGreenColor:UIColor{
        return UIColor.init(named: "GreenColor") ?? UIColor.black
    }
    class var appYellowColor:UIColor{
        return UIColor.init(named: "YellowColor") ?? UIColor.black
    }
    class var appPinkColor:UIColor{
        return UIColor.init(named: "PinkColor") ?? UIColor.black
    }
    class var appOrangeColor:UIColor{
        return UIColor.init(named: "OrangeColor") ?? UIColor.black
    }
    class var appLightGreyColor:UIColor{
        return UIColor.init(named: "LightGreyColor") ?? UIColor.black
    }
    class var appGreyColor:UIColor{
        return UIColor.init(named: "GreyColor") ?? UIColor.black
    }
    class var appDarkGreyColor:UIColor{
           return UIColor.init(named: "DarkGreyColor") ?? UIColor.black
    }
    class var appBlackWithAlpha50Color:UIColor{
           return UIColor.init(named: "BlackWithAlpha50Color") ?? UIColor.black
    }
    class var appBlackWithAlpha40Color:UIColor{
           return UIColor.init(named: "BlackWithAlpha40Color") ?? UIColor.black
    }
    class var appBlackWithAlpha35Color:UIColor{
           return UIColor.init(named: "BlackWithAlpha35Color") ?? UIColor.black
    }
    class var appBackgroundWhiteColor:UIColor{
           return UIColor.init(named: "BackgroundWhiteColor") ?? UIColor.black
    }
    class var appTintColor:UIColor{
        return self.appGreenColor
    }
}

