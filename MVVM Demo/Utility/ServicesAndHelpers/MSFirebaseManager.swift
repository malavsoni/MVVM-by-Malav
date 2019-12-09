//
//  FirebaseManager.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

import FirebaseAuth
class MSFirebaseManager: NSObject {
    
    struct AuthenticationInfo {
        var email:String = ""
        var password:String = ""
        var mobileNumber:String = ""
        var mobileVerificationCode:String = ""
        var username:String = ""
        var profilePictureURL = ""
        var authSource:MSFirebaseManager.AuthSource = .email
        init() {
            
        }
    }
    
    enum AuthSource {
        case email
        case facebook
        case mobile
        case google
    }
    
    typealias AuthenticationCompletionHandler = ((Bool,AuthenticationInfo?,String?)->())
    
    override init() {
        super.init()
        
        //Auth.auth().languageCode = "en";
    }
    
    func authenticate(withCredential credential:AuthCredential, withCompletion completion: @escaping ((User?,Error?)->Void)) -> Void{
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                completion(nil,error)
                return
            }
            if let user = authResult?.user{
                completion(user,nil)
                return
            }else{
                completion(nil,nil)
            }
        }
    }
        
    func logout() -> Void{
        try? Auth.auth().signOut()
    }
}
