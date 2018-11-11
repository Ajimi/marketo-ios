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
    private func performRequest(route:UserRouter, completion:@escaping (Result<Any>)->Void){
        Alamofire.request(route)
            .responseJSON{ (response: DataResponse<Any>) in
                completion(response.result)
        }
    }
    private func login(email: String, password: String, completion:@escaping (Result<Any>)->Void)  {
        performRequest(route: UserRouter.loginUser(email: email, password: password), completion: completion)
    }

}

// Mark UserRepository implementation
extension UserRemoteRepository : UserDataSource{
    
    func login(a user: User, completion:@escaping (Result<Any>)->Void)  {
        self.login(email: user.email, password: user.password , completion: completion)
    }
    
    func getAll() -> [User] {
        return [User]()
    }
    
    func get(identifier: Int) -> User? {
        return User(fullName: "", username: "", password: "", email: "")
    }
    
    func create(a: User) -> Bool {
        return true
    }
    
    func update(a: User) -> Bool {
        return true
    }
    
    func delete(a: User) -> Bool {
        return true
    }
    
    
//
//    public func signUp(user:User, completion:@escaping (Result<Any>)->Void) {
//        performRequest(route: UserRouter.createUser(user: user), completion: completion)
//    }
    
}
