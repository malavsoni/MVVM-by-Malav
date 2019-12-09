//
//  MSTableView.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class MSTableView: TPKeyboardAvoidingTableView {
     
    typealias TableViewDidSelectHandler = ((IndexPath,Any?)->())
    typealias TableViewDidScrollHandler = ((CGPoint)->())
    
    var tableViewState:MSView.State = .loading
    
    var didSelectRowNotification:TableViewDidSelectHandler?
    var didScrollTableViewNotification:TableViewDidScrollHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() -> Void {
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .singleLine
        self.separatorColor = nil
        self.backgroundColor = UIColor.clear
        self.tableFooterView = UIView.init(frame: .zero)
    }
    
    func showBackgroundView(WithMessage message:String) -> Void {
        let backgroundView = UIView.init(frame: self.bounds)
        let lblMessage:MSLabel = MSLabel(frame: backgroundView.bounds)
        lblMessage.textAlignment = .center
        lblMessage.text = message
        lblMessage.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        lblMessage.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        backgroundView.addSubview(lblMessage)
        self.backgroundView = backgroundView
    }
    
    func hideBackgroundView() -> Void {
        self.backgroundView = nil
    } 
}

extension MSTableView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReference = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        return cellReference!
    }
}

extension MSTableView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRowNotification?(indexPath,nil)
    }
}
