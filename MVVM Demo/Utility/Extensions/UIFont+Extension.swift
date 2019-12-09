//
//  UIFont+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension UIFont{
    class func logAllFonts() -> Void {
        for family in UIFont.familyNames {
            let sName: String = family as String
            print("family: \(sName)")
            for name in UIFont.fontNames(forFamilyName: sName) {
                print("name: \(name as String)")
            }
        }
    }
    
    fileprivate class func getFont(WithName fontName:String,WithSize size:CGFloat,_ shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        let sizeOfFont = shouldAdjustBasedOnDevice ? size.proportionateFontSize() : size
        return UIFont.init(name: fontName, size: sizeOfFont)!
    }
    
    class func SFProDisplayBold(withSize size:CGFloat,_ shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        return self.getFont(WithName: "SFProDisplay-Bold", WithSize: size, shouldAdjustBasedOnDevice)
    }
    class func SFProDisplayRegular(withSize size:CGFloat,_ shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        return self.getFont(WithName: "SFProDisplay-Regular", WithSize: size, shouldAdjustBasedOnDevice)
    }
    class func SFProDisplayMedium(withSize size:CGFloat,_ shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        return self.getFont(WithName: "SFProDisplay-Medium", WithSize: size, shouldAdjustBasedOnDevice)
    }
    class func SFProTextRegular(withSize size:CGFloat,_ shouldAdjustBasedOnDevice:Bool = true) -> UIFont{
        return self.getFont(WithName: "SFProText-Regular", WithSize: size, shouldAdjustBasedOnDevice)
    }
    
    //Categories Font
    class func headingFont() -> UIFont {
        return self.SFProDisplayBold(withSize: 30.0)
    }
    class func standardLabelFont() -> UIFont {
        return self.SFProDisplayRegular(withSize: 14.0)
    }
    class func standardLabelLargeFont() -> UIFont {
        return self.SFProDisplayRegular(withSize: 18.0)
    }
    class func standardButtonFont() -> UIFont {
        return self.SFProTextRegular(withSize: 14.0)
    }
    class func standardButtonLargeFont() -> UIFont {
        return self.SFProDisplayRegular(withSize: 18.0)
    }
    class func standardTextFieldFont() -> UIFont {
        return self.SFProDisplayRegular(withSize: 18.0)
    }
}


