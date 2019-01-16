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


struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, first!name,"]
    var accessToken = FacebookCore.AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}


class LoginFacebookUseCase {
    let loginRepository : UserRepository
    init(loginRepository: UserRepository = UserRepository()){
        self.loginRepository = loginRepository
    }
    
    func execute(viewController : UIViewController, completion:@escaping (Result<String>)->Void) {
        
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: viewController){ loginResult in
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
                
                let connection = GraphRequestConnection()
                connection.add(MyProfileRequest()) { response, result in
                    switch result {
                    case .success(let response):
                        print("Custom Graph Request Succeeded: \(response)")
                        // print("My facebook id is \(response.dictionaryValue?["id"])")
                        // print("My name is \(response.dictionaryValue?["name"])")
                    case .failed(let error):
                        print("Custom Graph Request Failed: \(error)")
                    }
                }
                connection.start()
                
                completion(Result(value : {
                    return "Login Successful"
                }))
                
            }
        }
        

    }
}
