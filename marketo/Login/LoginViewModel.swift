//
//  LoginViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire




class LoginViewModel: NSObject {
    
    var isLoggedIn:Bool? = false
    
    func login(withUsername username : String,withPassword password:String) {
    
        let repository = UserRepository()
        
        repository.login(a: User(username: username, password: password,email :username) ) { (result) in
            switch result as! Result<Any> {
            case .success(let accessToken):
                print(accessToken)
                self.isLoggedIn = true
            // TODO : ADD AccessToken
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoggedIn = false
            }
        }
    }
    
}
