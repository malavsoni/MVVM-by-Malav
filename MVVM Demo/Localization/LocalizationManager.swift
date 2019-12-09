//
//  LocalizationManager.swift
//  MVVM Demo
//
//  Created by Malav Soni on 12/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import Foundation

enum LocalizationStringContentType:String {
    case buttons = "ButtonsMessages"
    case staticMessages = "LabelsMessages"
    case textFieldPlaceholder = "TextFieldPlaceholderMessages"
    case validationMessages = "ValidationMessages"
}

struct GlobalMessages {
    var somethingWentWrongWithServer:String {
        return "somethingWentWrong".localizedMessagesString()
    }
}

struct LoginControllerStrings {
    var welcomeMessage:String { "welcome".localizedMessagesString() }
    var signInToContinueMessage:String { "signInToContinue".localizedMessagesString() }
    var signUpButton:String { "signup".localizedButtonString() }
    
    var email:String { "email".localizedMessagesString() }
    var emailPlaceholder:String { "emailPlaceholder".localizedPlaceholderString() }
    
    var password:String { "password".localizedMessagesString() }
    var passwordPlaceholder:String { "passwordPlaceholder".localizedPlaceholderString() }
    
    var forgotPasswordButton:String { "forgotPasswordButton".localizedButtonString()}
    var signInButton:String { "signInButton".localizedButtonString() }
    
    var strOr:String { "strOR".localizedMessagesString() }
    var signInWithFacebook:String { "strSignInWithFacebook".localizedButtonString() }
    var signInWithGoogle:String { "strSignInWithGoogle".localizedButtonString()}
}

struct ValidationMessages {
    var enterEmail:String { return "enterEmail".localizedValidationMessagesString()}
    var enterValidEmail:String { return "enterValidEmail".localizedValidationMessagesString()}
    var enterPassword:String { return "enterPassword".localizedValidationMessagesString()}
    var internetConnectionError:String { return "internetConnectionError".localizedValidationMessagesString()} 
}

struct AlertControllerStrings {
    var title:String { return "alertTitle".localizedButtonString() }
    var btnSettings:String { return "alertButtonSettings".localizedButtonString() }
    var btnOkay:String { return "alertButtonOk".localizedButtonString() }
    var btnLogin:String { return "alertButtonLogin".localizedButtonString()}
    var btnCancel:String { return "alertButtonCancel".localizedButtonString()}
}
