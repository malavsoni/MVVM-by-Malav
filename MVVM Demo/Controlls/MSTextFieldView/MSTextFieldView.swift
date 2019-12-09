//
//  MSTextFieldView.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class MSTextFieldView: UIView {

    enum ContentType {
        case none
        case email
        case password
    }
    
    var contentType:ContentType = .none{
        didSet{
            switch self.contentType {
            case .none:
                self.lblPlaceholder.text = ""
                self.tfValueContainer.text = ""
                break
            case .email:
                self.lblPlaceholder.text = "Email"
                self.tfValueContainer.placeholder = "iamdavid@gmail.com"
                break
            case .password:
                self.lblPlaceholder.text = "Password"
                self.tfValueContainer.placeholder = "* * * * * *"
                self.tfValueContainer.isSecureTextEntry = true
                break
            }
        }
    }
    
    @IBOutlet weak private var lblPlaceholder: MSLabel!
    @IBOutlet weak private var tfValueContainer: MSUnderlineTextField!
    
    var nextTextFieldViewResponder:MSTextFieldView?{
        didSet{
            if let responder = nextTextFieldViewResponder{
                self.tfValueContainer.nextTextField = responder
            }else{
                self.tfValueContainer.nextTextField = nil
            }
        }
    }
    
    var text:String?{
        return self.tfValueContainer.text
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.xibSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.xibSetup()
    }

    override func xibSetup() {
        super.xibSetup()
        self.tfValueContainer.placeholder = ""
    }
    
    override func becomeFirstResponder() -> Bool {
        return tfValueContainer.becomeFirstResponder()
    }
    
    
}
