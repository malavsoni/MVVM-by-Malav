//
//  MSFacebookButton.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MSFacebookButton: FBLoginButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func updateConstraints() {
        // deactivate height constraints added by the facebook sdk (we'll force our own instrinsic height)
        for contraint in constraints {
            if contraint.firstAttribute == .height {
                // deactivate this constraint
                contraint.isActive = false
            }
        }
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() -> Void {
        //self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 18, bottom: 0, right: 10)
        self.permissions = ["public_profile","email"]
    }

}
