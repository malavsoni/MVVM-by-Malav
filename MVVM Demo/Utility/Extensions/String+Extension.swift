//
//  String+Extension.swift
//  MVVM Demo
//
//  Created by Malav Soni on 11/11/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import Foundation

extension String{
    func localizedString(WithType type:LocalizationStringContentType) -> String {
        return NSLocalizedString(self, tableName: type.rawValue, bundle: Bundle.main, value: "FailedToFetchLocalizedString", comment: "Error")
    }
    func localizedButtonString() -> String {
        return NSLocalizedString(self, tableName: LocalizationStringContentType.buttons.rawValue, bundle: Bundle.main, value: "FailedToFetchLocalizedString", comment: "Error")
    }
    func localizedPlaceholderString() -> String {
        return NSLocalizedString(self, tableName: LocalizationStringContentType.textFieldPlaceholder.rawValue, bundle: Bundle.main, value: "FailedToFetchLocalizedString", comment: "Error")
    }
    func localizedMessagesString() -> String {
        return NSLocalizedString(self, tableName: LocalizationStringContentType.staticMessages.rawValue, bundle: Bundle.main, value: "FailedToFetchLocalizedString", comment: "Error")
    }
    func localizedValidationMessagesString() -> String {
        return NSLocalizedString(self, tableName: LocalizationStringContentType.validationMessages.rawValue, bundle: Bundle.main, value: "FailedToFetchLocalizedString", comment: "Error")
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let strPasswordValue = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) 
        return strPasswordValue.count >= 8
    }
    
    func trimBlankSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
