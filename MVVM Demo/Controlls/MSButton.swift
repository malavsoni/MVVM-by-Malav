//
//  MSButton.swift
//  MVVM Demo
//
//  Created by Malav Soni on 24/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class MSButton: UIButton {

    enum MSButtonStyle {
        case none,socialMedia,standard,large
    }
    
    var buttonStyle:MSButtonStyle = .standard{
        didSet{
            switch self.buttonStyle {
                case .none:
                    titleLabel?.font = UIFont.SFProDisplayRegular(withSize: 14.0)
                    break
                case .standard:
                    titleLabel?.font = UIFont.SFProDisplayRegular(withSize: 18.0)
                    self.setTitleColor(UIColor.appTintColor, for: UIControl.State.normal)
                    break
                case .socialMedia:
                    titleLabel?.font = UIFont.SFProTextRegular(withSize: 14.0)
                    self.addBorder()
                    self.addCornerRadius(withRadius: self.frame.size.height * 0.1)
                    break
                case .large:
                    titleLabel?.font = UIFont.SFProTextRegular(withSize: 14.0)
                    self.addCornerRadius(withRadius: self.frame.size.height * 0.1)
                    self.backgroundColor = UIColor.appTintColor
                    self.setTitleColor(UIColor.white, for: UIControl.State.normal)
                    break
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
