//
//  LoginViewController.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import UIKit

class LoginViewController: SuperViewController {

    // Views
    @IBOutlet weak var viewLoginWithCredentials: UIView!
    
    // Labels
    @IBOutlet weak var lblOR: MSLabel!
    @IBOutlet weak var lblTitle: MSLabel!
    @IBOutlet weak var lblSubTitle: MSLabel!
    
    // Buttons
    @IBOutlet weak var btnLoginWithFacebook: MSFacebookButton!
    @IBOutlet weak var btnLoginWithGoogle: MSGoogleButton!
    @IBOutlet weak var btnSignup: MSButton!
    @IBOutlet weak var btnForgotPassword: MSButton!
    @IBOutlet weak var btnSignIn: MSButton!
    
    // TextField
    @IBOutlet weak var tfEmailView: MSTextFieldView!
    @IBOutlet weak var tfPasswordView: MSTextFieldView!
    
    private var viewModel:LoginViewModel!
    
    //MARK:- Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupController()
        self.setupLocalisation()
        self.setupObservers()
    }
    
    private func setupUI() -> Void{
        
        // View UI
        self.viewLoginWithCredentials.addGlowEffect()
        self.viewLoginWithCredentials.addCornerRadius()
        
        // Label UI
        self.lblTitle.font = UIFont.SFProDisplayRegular(withSize: 30.0)
        self.lblSubTitle.font = UIFont.SFProDisplayRegular(withSize: 14.0)
        
        // TextField UI
        self.tfEmailView.contentType = .email
        self.tfEmailView.nextTextFieldViewResponder = self.tfPasswordView
        self.tfPasswordView.contentType = .password
        
        // Buttons UI
        self.btnSignIn.buttonStyle = .large
        self.btnForgotPassword.buttonStyle = .none
        self.btnSignup.buttonStyle = .standard
    }
    
    func setupController() -> Void{
        self.viewModel = LoginViewModel(withDelegate: self)
        self.viewModel.setupGoogle(withController: self)
        self.btnLoginWithFacebook.delegate = self.viewModel.setupFacebook()
    }
    
    private func setupLocalisation() -> Void{
        let localizeValues = LoginControllerStrings()
        self.lblTitle.text = localizeValues.welcomeMessage
        self.lblSubTitle.text = localizeValues.signInToContinueMessage
        self.btnSignup.setTitle(localizeValues.signUpButton, for: UIControl.State.normal)
        self.btnForgotPassword.setTitle(localizeValues.forgotPasswordButton, for: UIControl.State.normal)
        self.btnSignIn.setTitle(localizeValues.signInButton, for: UIControl.State.normal)
        self.lblOR.text = localizeValues.strOr
    }
    
    private func setupObservers() -> Void{
        // TableView Observers If Any
    }
    
    //MARK:- User Actions
    @IBAction func btnSignIn_Clicked(_ sender: Any) {
        self.viewModel.validateCredentials(withEmail: self.tfEmailView.text, andPassword: self.tfPasswordView.text)
    }
}

//MARK:- LoginViewModelProtocol
extension LoginViewController:LoginViewModelProtocol{
    func userLoggedInSuccessfully() {
        AppDelegate.change(rootController: UIStoryboard.getViewController(withIdentifier: "countryListNavigationController", fromStoryboard: MSStoryboard.country))
    }
    
    func failedToLoggedIn(withErrorMessage errorMessage: String) {
        UIAlertController.showActionSheet(andMessage: errorMessage, andButtonTitles: [], andCancelButton: AlertControllerStrings().btnOkay, andSelectionHandler: nil)
    }
    
    
}
