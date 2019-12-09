//
//  FacebookHelper.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//


import FBSDKLoginKit
import FirebaseAuth
import FBSDKCoreKit

protocol MSFacebookHelpersEventsProtocol:class {
    func fbUserLoggedInSuccessfully(withInformation authInfo:MSFirebaseManager.AuthenticationInfo) -> Void
    func failedToValidateFBUser(withError error:Error?) -> Void
    func facebookLogoutSuccessfully() -> Void
}

class MSFacebookHelper: MSFirebaseManager {
    
    weak var delegate:MSFacebookHelpersEventsProtocol?
    
    init(withDelegate delegate:MSFacebookHelpersEventsProtocol) {
        super.init()
        self.delegate = delegate
    }
    
    override func logout() {
        LoginManager().logOut() 
        super.logout()
    }
}

extension MSFacebookHelper:LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error{
             self.delegate?.failedToValidateFBUser(withError: error)
        }else if let result = result{
            if result.isCancelled{
                // User cancel the action so do not do anything.
            }else{
                if let accessToken = AccessToken.current{
                    let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                    self.authenticate(withCredential: credential) { (userInfo, error) in
                        if let error = error {
                            self.delegate?.failedToValidateFBUser(withError: error)
                            return
                        }else if let user = userInfo{
                            var authInformation = AuthenticationInfo()
                            authInformation.authSource = MSFirebaseManager.AuthSource.facebook
                            authInformation.email = user.email ?? ""
                            authInformation.username = user.displayName ?? ""
                            if let photoURL = user.photoURL{
                                authInformation.profilePictureURL = photoURL.absoluteString + "?type=large"
                            }
                            self.delegate?.fbUserLoggedInSuccessfully(withInformation: authInformation)
                        }else{
                            self.delegate?.failedToValidateFBUser(withError: nil)
                        }
                    }
                }else{
                    self.delegate?.failedToValidateFBUser(withError: nil)
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        self.logout()
        self.delegate?.facebookLogoutSuccessfully()
    }
    
    func isFacebookUserAlreadyLoggedIn() -> Bool {
        return AccessToken.isCurrentAccessTokenActive
    }
    
    class func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, options: options)
    }
}
