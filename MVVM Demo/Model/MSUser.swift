//
//  MSUser.swift
//  MVVM Demo
//
//  Created by Malav Soni on 08/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

/// Signleton class which holds loggedin user's information
class MSUser: NSObject,Codable {
    static public let current = MSUser.init()
    
    private let userKey = "userInfo"
    
    /// User ID
    @objc var id:String = ""
    
    /// username of the user
    @objc var username:String = "" 
    
    /// Email of the user
    @objc var email:String = ""
    
    private override init() {
        super.init()
        
        if let encodeObject:Data = UserDefaults.standard.object(forKey: userKey) as? Data{
            // User Found
            if let savedObj:MSUser = NSKeyedUnarchiver.unarchiveObject(with: encodeObject) as? MSUser{
                self.id = savedObj.id
                self.email = savedObj.email
                self.username = savedObj.username
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: #keyPath(MSUser.id))
        aCoder.encode(self.username, forKey: #keyPath(MSUser.username))
        aCoder.encode(self.email, forKey: #keyPath(MSUser.email))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.id = aDecoder.decodeObject(forKey: #keyPath(MSUser.id)) as? String ?? ""
        self.username = aDecoder.decodeObject(forKey: #keyPath(MSUser.username)) as? String ?? ""
        self.email = aDecoder.decodeObject(forKey: #keyPath(MSUser.email)) as? String ?? ""
    }
    
    
    
    func save() -> Void {
        //self.selectedStore?.save()
        let currentUserRef:Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(currentUserRef, forKey: userKey)
        UserDefaults.standard.synchronize()
    }
    
    func isUserloggedIn() -> Bool {
        return !self.id.isEmpty
    }
    
    func resetDetails() -> Void {
        id = ""
        username = ""
        email = ""
        self.save()
    }
    
    func updateDetails(WithContent content:[String:Any]) -> Void {
        if let value = content[#keyPath(MSUser.id)] as? String{
            self.id = value
        }
        if let value = content[#keyPath(MSUser.username)] as? String{
            self.username = value
        }
        if let value = content[#keyPath(MSUser.email)] as? String{
            self.email = value
        } 
        save()
    }
    func updateDetails(WithContent content:MSFirebaseManager.AuthenticationInfo) -> Void{
        self.email = content.email
    }
}
