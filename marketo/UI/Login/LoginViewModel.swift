//
//  LoginViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


class LoginViewModel: NSObject {
    
//    var isLoggedIn = Dynamic<Bool>(false)
//    var errorEvent = Dynamic<String>("")
    let loginFacebookUseCase : LoginFacebookUseCase = LoginFacebookUseCase()
    let loginGoogleUseCase : LoginGoogleUseCase = LoginGoogleUseCase()
    var uiState =  Dynamic<LoginUiModel>(LoginUiModel(showProgress: false, showError: nil , showSuccess: nil))
    let repository = UserRepository()
    var vc : UIViewController?
    
    func loginFacebook(){
        loginFacebookUseCase.execute(viewController: vc!) { (result) in
            switch result{
            case .success(let accessToken):
                print(accessToken)
                self.emitUiState(showProgress: false,showSuccess: Event(with: "Connected"))
            case .failure(let error):
                self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func loginGoogle(){
        loginGoogleUseCase.execute() { (result) in
            switch result{
            case .success(let accessToken):
                print(accessToken)
                self.emitUiState(showProgress: false,showSuccess: Event(with: "Connected"))
            case .failure(let error):
                self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func login(withUsername username : String,withPassword password:String) {
        emitUiState(showProgress: true)
        repository.login(a: User(username: username, password: password,email :username) ) { (result) in
            switch result {
            case .success:
                self.emitUiState(showProgress: false,showSuccess: Event(with: "Connected"))
            case .failure(let error):
                self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
}

extension LoginViewModel {
    private func emitUiState(
    showProgress: Bool = false,
    showError: Event<String>? = nil,
    showSuccess: Event<String>? = nil
    ) {
        let uiModel = LoginUiModel(showProgress: showProgress, showError: showError, showSuccess: showSuccess)
        uiState.value = uiModel
    }
}


struct LoginUiModel {
    var showProgress: Bool
    var showError: Event<String>?
    var showSuccess: Event<String>?
}

