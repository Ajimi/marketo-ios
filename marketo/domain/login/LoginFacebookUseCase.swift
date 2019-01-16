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
        var name: String?
        var id: String?
        var gender: String?
        var email: String?
        
        init(rawResponse: Any?) {
            // Decode JSON from rawResponse into other properties here.
            guard let response = rawResponse as? Dictionary<String, Any> else {
                return
            }
            
            if let name = response["name"] as? String {
                self.name = name
            }
            
            if let id = response["id"] as? String {
                self.id = id
            }
            
            if let gender = response["gender"] as? String {
                self.gender = gender
            }
            
            if let email = response["email"] as? String {
                self.email = email
            }
        }
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name,email, first_name"]
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
                
                let connection = GraphRequestConnection()
                connection.add(MyProfileRequest()) { response, result in
                    switch result {
                    case .success(let response):
                        
                
                        self.loginRepository.loginSocialMedia(a: User(fullName: response.name, username: response.name, password: response.id, email: response.email, type: "facebook"),with: "facebook", withAccessToken: accessToken.authenticationToken)
                        
                        
                    case .failed(let error):
                        print("Custom Graph Request Failed: \(error)")
                    }
                    completion(Result(value : {
                        return "Login Successful"
                    }))
                }
                connection.start()
                
                
            }
        }
    }
}
