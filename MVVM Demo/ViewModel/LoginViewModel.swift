//
//  LoginViewModel.swift
//  MVVM Demo
//
//  Created by Malav Soni on 04/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

typealias ValidationStatus = (status:Bool,errorMessage:String)

protocol LoginViewModelProtocol:class {
    func userLoggedInSuccessfully() -> Void
    func failedToLoggedIn(withErrorMessage errorMessage:String) -> Void
}

class LoginViewModel: NSObject {
    
    weak private var delegate:LoginViewModelProtocol?
    private var fbManager:MSFacebookHelper?
    private var googleManager:MSGoogleHelper?
    private lazy var localizeStrings = ValidationMessages()
    
    init(withDelegate delegate:LoginViewModelProtocol) {
        super.init()
        self.delegate = delegate
    }
    
    @discardableResult
    func setupFacebook() -> LoginButtonDelegate?{
        fbManager = MSFacebookHelper.init(withDelegate: self)
        return fbManager
    }
    
    func setupGoogle(withController controller:UIViewController) -> Void{
        self.googleManager = MSGoogleHelper.init(withPresentingController: controller, andDelegate: self)
    }
    
    func validateCredentials(withEmail email:String?,andPassword password:String?) -> Void {
        
        // Validate Email
        var validationResult = self.validate(email: email)
        guard validationResult.status == true else {
            self.delegate?.failedToLoggedIn(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Validate Password
        validationResult = self.validate(password: password)
        guard validationResult.status == true else {
            self.delegate?.failedToLoggedIn(withErrorMessage: validationResult.errorMessage)
            return
        }
        
        // Check for Internet Connection
        guard MSServiceManager.shared.isInternetAvailable() else {
            self.delegate?.failedToLoggedIn(withErrorMessage: ValidationMessages().internetConnectionError)
            return
        }
        
        // Call Login API
        // Implement your login api call here
        self.delegate?.failedToLoggedIn(withErrorMessage: "You forgot to implement your LOGIN API call in LoginViewModel Class\nOr you can Try to login with Google or Facebook")
    }
}


// Validate your inputs
extension LoginViewModel{
    func validate(email:String?) -> ValidationStatus {
        guard let emailValue = email,emailValue.isEmpty == false else {
            return (false,localizeStrings.enterEmail)
        }
        if emailValue.isValidEmail() == false{
            return (false,localizeStrings.enterValidEmail)
        }
        return (true,"")
    }
    
    func validate(password:String?) -> ValidationStatus {
        guard let passwordValue = password, passwordValue.isEmpty == false else {
            return (false,localizeStrings.enterPassword)
        }
        return (true,"")
    }
}

extension LoginViewModel:MSGoogleHelperEventsProtocol{
    func googleUserLoggedInSuccessfully(withInformation authInfo: MSFirebaseManager.AuthenticationInfo) {
        MSUser.current.updateDetails(WithContent: authInfo)
        self.delegate?.userLoggedInSuccessfully()
    }
    
    func failedToValidateGoogleUser(withError error: Error?) {
        self.googleManager?.logout()
        self.delegate?.failedToLoggedIn(withErrorMessage: error?.localizedDescription ?? GlobalMessages().somethingWentWrongWithServer)
    }
    
    func googleLogoutSuccessfully() {
        
    }
}

extension LoginViewModel:MSFacebookHelpersEventsProtocol{
    func fbUserLoggedInSuccessfully(withInformation authInfo: MSFirebaseManager.AuthenticationInfo) {
        MSUser.current.updateDetails(WithContent: authInfo)
        self.delegate?.userLoggedInSuccessfully()
    }
    
    func failedToValidateFBUser(withError error: Error?) {
        self.fbManager?.logout()
        self.delegate?.failedToLoggedIn(withErrorMessage: error?.localizedDescription ?? GlobalMessages().somethingWentWrongWithServer)
    }
    
    func facebookLogoutSuccessfully() {
        
    }
}
