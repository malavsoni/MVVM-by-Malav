//
//  UIAlertController+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func alertAfterDelay(WithMessage message: String, andTitle title: String = AlertControllerStrings().title) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            UIAlertController.alert(message: message)
        }
    }
    
    static func alert(message: String, andSelectionHandler selectionHandler:((Int)->())? = nil) {
        self.showAlert(andMessage: message, andButtonTitles: [AlertControllerStrings().btnOkay], andSelectionHandler: selectionHandler)
    }
    
    static func showAlert(withTitle title:String = AlertControllerStrings().title,andMessage message:String, andButtonTitles aryButtons:[String], andSelectionHandler selectionHandler:((Int)->())?) -> Void{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (index,title) in aryButtons.enumerated(){
            let action = UIAlertAction.init(title: title, style: aryButtons.count == 1 ? UIAlertAction.Style.cancel : UIAlertAction.Style.default) { (alertAction) in
                selectionHandler?(index)
            }
            alertController.addAction(action)
        }
        
        if let rootController = UIApplication.getTopMostViewController(){
            rootController.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func showActionSheet(withTitle title:String = AlertControllerStrings().title,andMessage message:String, andButtonTitles aryButtons:[String], andCancelButton cancelButtonTitle:String, andSelectionHandler selectionHandler:((Int)->())?) -> Void{
        
        let alertController = UIAlertController(title: title == "" ? nil : title, message: message == "" ? nil : message, preferredStyle: .actionSheet)
        
        let action = UIAlertAction.init(title: cancelButtonTitle, style: UIAlertAction.Style.cancel) { (alertAction) in
            selectionHandler?(0)
        }
        alertController.addAction(action)
        
        for (index,title) in aryButtons.enumerated(){
            let action = UIAlertAction.init(title: title, style: UIAlertAction.Style.default) { (alertAction) in
                selectionHandler?(index+1)
            }
            alertController.addAction(action)
        }
        
        if let rootController = UIApplication.getTopMostViewController(){
            rootController.present(alertController, animated: true, completion: nil)
        }
    }
}
