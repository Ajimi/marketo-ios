//
//  UserService.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class UserService {
    
    private static func performRequest(route:UserRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<Any>)->Void) -> DataRequest {
        return Alamofire.request(route)
            .responseJSON{ (response: DataResponse<Any>) in
                completion(response.result)
        }
    }
    
    public static func login(email: String, password: String, completion:@escaping (Result<Any>)->Void) -> DataRequest {
        return performRequest(route: UserRouter.loginUser(email: email, password: password), completion: completion)
    }
    
    public static func signUp(user:User, completion:@escaping (Result<Any>)->Void) -> DataRequest {
        return performRequest(route: UserRouter.createUser(user: User), completion: completion)
    }
    
}
