//
//  UserService.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire




class UserRemoteRepository{
    
    @discardableResult
    private func performRequest<T:Decodable>(route:UserRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseJSONDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
  
    private func login(email: String, password: String, completion:@escaping (Result<AccessToken>)->Void)  {
        performRequest(route: UserRouter.loginUser(email: email, password: password), completion: completion)
    }
}

// Mark UserRepository implementation
extension UserRemoteRepository{
    
    func login(a user: User, completion:@escaping (Result<AccessToken>)->Void)  {
        self.login(email: user.email!, password: user.password! , completion: completion)
    }
    
    func register(a user: User, completion:@escaping (Result<User>)->Void)  {
        performRequest(route: UserRouter.createUser(user: user), completion: completion)
    }
}
