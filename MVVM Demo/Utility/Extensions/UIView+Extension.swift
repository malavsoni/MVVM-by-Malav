//
//  UIView+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

extension UIView{
    @objc func xibSetup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let view = loadNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        view.backgroundColor = .clear
        
        // Adding custom subview on top of our view
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view])) 
    }
    
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func addGlowEffect() -> Void{
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
    }
    
    func addCornerRadius(withRadius radius:CGFloat = 8.0) -> Void{
        self.layer.cornerRadius = radius
    }
    
    func addBorder(withColor color:UIColor = UIColor.lightGray, andSize size:CGFloat = 1) -> Void
    {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}
