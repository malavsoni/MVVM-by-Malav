//
//  CGFloat+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension CGFloat{
    func proportionateFontSize() -> CGFloat {
        var returnValue = self
        switch UIDevice.current.type {
            
        case .iPad:
            break
        case .iPhone_unknown:
            break
        case .iPhone_5_5S_5C:
            returnValue = self - 2.75
            break
        case .iPhone_6_6S_7_8:
            returnValue = self - 1.5
            break
        case .iPhone_6_6S_7_8_PLUS:
            returnValue = self
            break
        case .iPhone_X_Xs_11Pro:
            returnValue = self
            break
        case .iPhone_Xs_Max_11ProMax:
            returnValue = self + 1.5
            break
        case .iPhone_Xr_11:
            returnValue = self + 0.25
            break
        }
        return returnValue
    }
}
