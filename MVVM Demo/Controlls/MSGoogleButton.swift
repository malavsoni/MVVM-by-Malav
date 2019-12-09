//
//  MSGoogleButton.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import GoogleSignIn

class MSGoogleButton: GIDSignInButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
     
    
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
    }

}
