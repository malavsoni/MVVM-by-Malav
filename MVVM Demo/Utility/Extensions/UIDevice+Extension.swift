//
//  UIDevice+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension UIDevice {
    
    enum `Type` {
        case iPad
        case iPhone_unknown
        case iPhone_5_5S_5C
        case iPhone_6_6S_7_8
        case iPhone_6_6S_7_8_PLUS
        case iPhone_X_Xs_11Pro
        case iPhone_Xs_Max_11ProMax
        case iPhone_Xr_11
    }
    
    var type: Type {
        if userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return .iPhone_5_5S_5C
            case 1334:
                return .iPhone_6_6S_7_8
            case 1920, 2208:
                return .iPhone_6_6S_7_8_PLUS
            case 2436:
                return .iPhone_X_Xs_11Pro
            case 2688:
                return .iPhone_Xs_Max_11ProMax
            case 1792:
                return .iPhone_Xr_11
            default:
                return .iPhone_unknown
            }
        }
        return .iPad
    }
    
    func getSafeAreaBottomHeight() -> CGFloat {
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate!.window
            return window?!.safeAreaInsets.bottom ?? 0.0
        }
        return 0.0
    }
    func getSafeAreaTopHeight() -> CGFloat {
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        return 0.0
    }
    
    func getStandardConstraintValue() -> CGFloat {
        switch UIScreen.main.scale {
        case 1:
            return 8.0
        case 2:
            return 16.0
        case 3:
            return 20.0
        default:
            return 16.0
        }
    }
}
