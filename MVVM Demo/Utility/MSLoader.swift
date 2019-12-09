//
//  MSLoader.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import SVProgressHUD

class MSLoader: NSObject {
    
    static let shared = MSLoader()
    
    override private init() {
        super.init()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
    
    func showLoader(WithMessage message:String = "Loading") -> Void {
        OperationQueue.main.addOperation {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    func hideLoader() -> Void {
        OperationQueue.main.addOperation {
            SVProgressHUD.dismiss()
        }
    }
}
