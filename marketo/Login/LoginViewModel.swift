//
//  LoginViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
    
    let isLoggedIn:Bool? = false
    
    func authenticate(withUsername username : String,withPassword password:String){
        UserService.login(email: username, password: password) { (result) in
            switch result {
            case .success(let accessToken):
                print(accessToken)
            // TODO : ADD AccessToken
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
