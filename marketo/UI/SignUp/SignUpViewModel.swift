//
//  SignUpViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//
import UIKit
import Alamofire

struct BrokenRule{
    var propertyName : String
    var message : String
}

class SignUpViewModel: NSObject {
    
    // Use Dependency Injection
    let repository = UserRepository()

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
    var uiState =  Dynamic<SignUpUiModel>(SignUpUiModel(showProgress: false, showError: nil , showSuccess: nil))

}


// MARK : - Create USER
extension SignUpViewModel {
    func register() {
        // Todo USE Dependency Injection
        emitUiState(showProgress: true)
        if isValid {
            repository.register(a: user, completion: checkResponseFor)
        } else {
            emitUiState(showError: Event(with: self.prepareMessage()))
        }
    }

    func checkResponseFor(response : Result<User>) {
        switch response {
        case .success(let user):
            self.emitUiState(showSuccess: Event(with: user))
            
        // TODO: - Check Errors
        case .failure(let error):
            emitUiState(showError: Event(with: error.localizedDescription))
        }
    }
}


// MARK : -  Validation
extension SignUpViewModel {
    private func validate() {
        checkPassword()
        checkEmail()
    }
    
    private func checkPassword() {
        if confirmationPassword != user.password {
            addBrokenRule(propertyName: "Confirm Password", message: "Password Does Not Match")
        }
        
        if (user.password!.count < 8){
            addBrokenRule(propertyName: "Passwprd Length", message: "Password Must Be At Least 8 Characters Long")
        }
    }
    
    private func checkEmail(){
        if !isValidEmail(testStr: user.email!) {
            addBrokenRule(propertyName: "Email", message: "Email Format Should Be Valid (aze@aze.io)")
        }
    }
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._-]+@[A-Za-z]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func prepareMessage() -> String {
        var message : String = ""
        for br : BrokenRule in brokenRules{
            message += "-" + br.propertyName + ": " + br.message + "\n"
        }
        return message
    }
    
    
    func addBrokenRule(propertyName: String, message:String) {
        brokenRules.append(BrokenRule(propertyName: propertyName, message: message))
    }
}



extension SignUpViewModel {
    private func emitUiState(
        showProgress: Bool = false,
        showError: Event<String>? = nil,
        showSuccess: Event<User>? = nil
        ) {
        
        let uiModel = SignUpUiModel(showProgress: showProgress, showError: showError, showSuccess: showSuccess)
        uiState.value = uiModel
    }
}


struct SignUpUiModel {
    var showProgress: Bool
    var showError: Event<String>?
    var showSuccess: Event<User>?
}
