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
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
  
    private func login(username: String, password: String, completion:@escaping (Result<AccessToken>)->Void)  {
        performRequest(route: UserRouter.loginUser(username: username, password: password), completion: completion)
    }
}

// Mark UserRepository implementation
extension UserRemoteRepository{
    
    func login(a user: User, completion:@escaping (Result<AccessToken>)->Void)  {
        self.login(username: user.username!, password: user.password! , completion: completion)
    }
    
    func readUser(id:Int, token:String, completion:@escaping (Result<User>)->Void) {
        performRequest(route: UserRouter.readUser(id: id, token:token), completion: completion)
    }
    
    func register(a user: User, completion:@escaping (Result<User>)->Void)  {
        performRequest(route: UserRouter.createUser(user: user), completion: completion)
    }
    func modifyPassword(user: PasswordChangeRequest, token: String) {
        performRequest(route: UserRouter.modifyPassword(id: user.userId, user: user, token: token), completion: checkResponse)
    }
    
    func checkResponse(result : Result<User>) -> Void {
        print("Result")
    }
}
