//
//  GoogleHelper.swift
//  MVVM Demo
//
//  Created by Malav Soni on 03/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//
 
import Firebase
import GoogleSignIn

protocol MSGoogleHelperEventsProtocol:class {
    func googleUserLoggedInSuccessfully(withInformation authInfo:MSFirebaseManager.AuthenticationInfo) -> Void
    func failedToValidateGoogleUser(withError error:Error?) -> Void
    func googleLogoutSuccessfully() -> Void
}

class MSGoogleHelper: MSFirebaseManager {
    
    weak var delegate:MSGoogleHelperEventsProtocol?
    
    init(withPresentingController controller:UIViewController,andDelegate delegate:MSGoogleHelperEventsProtocol) {
        super.init()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = controller
        self.delegate = delegate
    }
    
    
    /// call this method to manually signin user
    func signInWithGoogle() -> Void{
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    class func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension MSGoogleHelper:GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        self.delegate?.failedToValidateGoogleUser(withError: error)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        self.authenticate(withCredential: credential) { (userInfo, error) in
            if let error = error {
                // ...
                self.delegate?.failedToValidateGoogleUser(withError: error)
                return
            }else if let user = userInfo{
                var authInformation = AuthenticationInfo()
                authInformation.authSource = MSFirebaseManager.AuthSource.facebook
                authInformation.email = user.email ?? ""
                authInformation.username = user.displayName ?? ""
                if let photoURL = user.photoURL{
                    authInformation.profilePictureURL = photoURL.absoluteString + "?type=large"
                }
                self.delegate?.googleUserLoggedInSuccessfully(withInformation: authInformation)
            }else{
                self.delegate?.failedToValidateGoogleUser(withError: error)
            }
        }
      // ...
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        self.delegate?.failedToValidateGoogleUser(withError: error)
    }
}
