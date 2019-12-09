//
//  MSUnderlineTextField.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit


class MSUnderlineTextField: MSTextField {

    private var bottomLineLayer:CAShapeLayer!
    
    private var activeTextFieldColor:UIColor = UIColor.appTintColor
    private var inActiveTextFieldColor:UIColor = UIColor.appLightGreyColor
    
    var bottomLineHeight:CGFloat = 1
    
    override func commonInit() {
        super.commonInit()
        self.setupBottomBorder()
        self.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupBottomBorder()
    }
    
    private func setupBottomBorder() -> Void{
        if bottomLineLayer == nil{
            bottomLineLayer = CAShapeLayer.init()
            self.layer.addSublayer(bottomLineLayer)
        }
        bottomLineLayer.frame = CGRect.init(x: 0, y: self.frame.size.height - bottomLineHeight, width: self.frame.size.width, height: bottomLineHeight)
        self.bottomLineLayer.backgroundColor = self.isFirstResponder ? self.activeTextFieldColor.cgColor : self.inActiveTextFieldColor.cgColor
        bottomLineLayer.cornerRadius = self.bottomLineHeight / 2.0
    }
}
