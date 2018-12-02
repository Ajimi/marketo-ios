//
//  LoginFacebookUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import Alamofire
import FacebookCore
import FacebookLogin

class LoginFacebookUseCase {
    let loginRepository : UserRepository
    init(loginRepository: UserRepository = UserRepository()){
        self.loginRepository = loginRepository
    }
    
    func execute(viewController : UIViewController, completion:@escaping (Result<String>)->Void) {
        
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: viewController){ loginResult in
            switch loginResult {
            case .failed(let error):
                completion(Result(value : {
                    throw error
                }))
            case .cancelled:
                completion(Result(value : {
                    throw LoginErrors.canceled(message: "Login Canceled")
                }))
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.loginRepository.loginSocialMedia(with: "facebook", withAccessToken: accessToken.authenticationToken)
                completion(Result(value : {
                    return "Login Successful"
                }))
                
            }
        }
        

    }
}
