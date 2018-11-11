//
//  SignUpViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//
import UIKit

struct BrokenRule{
    var propertyName : String
    var message : String
}

class SignUpViewModel: NSObject {
    
    var user : User!
    var confirmationPassword : String!
    var brokenRules : [BrokenRule]!
    var isValid :Bool {
        get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    func prepareMessage() -> String {
        var message : String = ""
        for br : BrokenRule in brokenRules{
            message += "-" + br.propertyName + ": " + br.message + "\n"
        }
        return message
    }
    
}

extension SignUpViewModel {
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    private func validate() {
        
        if (confirmationPassword != user.password)
        {
            brokenRules.append(BrokenRule(propertyName: "Confirm Password", message: "Password Does Not Match"))
        }
        
        if (user.password.count ?? 0 < 8)
        {
            brokenRules.append(BrokenRule(propertyName: "Passwprd Length", message: "Password Must Be At Least 8 Characters Long"))
        }
        
        if (!isValidEmail(testStr: user.email)){
            brokenRules.append(BrokenRule(propertyName: "Email", message: "Email Format Should Be Valid (aze@aze.io)"))
        }
        
        
    }
    
}
