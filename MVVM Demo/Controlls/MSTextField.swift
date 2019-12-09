//
//  MSTextField.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class MSTextField: UITextField {

    var nextTextField:UIView?{
        didSet{
            if self.nextTextField != nil{
                self.returnKeyType = .next
            }
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit() -> Void { 
        self.tintColor = UIColor.appTintColor
        self.returnKeyType = .done
        self.delegate = self
        self.font = UIFont.SFProDisplayRegular(withSize: 18.0)
    }
}

extension MSTextField: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextResponder = self.nextTextField else{
            return textField.resignFirstResponder()
        }
        return nextResponder.becomeFirstResponder()
    }
}
