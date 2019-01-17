//
//  UserLocalRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class UserLocalRepository{
    
    let authTokenRepository : AuthTokenRepository = AuthTokenRepository()
    
    var user:User? {
        get {
            let userId = UserDefaults.standard.integer(forKey: AuthenticationKey.keyUserId) ?? nil
            let username = UserDefaults.standard.string(forKey: AuthenticationKey.keyUserName) ?? nil
            let email = UserDefaults.standard.string(forKey: "email") ?? nil
            let type = UserDefaults.standard.string(forKey: "type") ?? nil
            guard userId != nil, username != nil, type != nil else {
                print("nullable")
                return nil
            }
            
            print("getting user")
            
            return User(fullName: username! ,username: username!,password: "",email: email!, type: type!, id: userId!)
        }
        set(value) {
            print("Sign in user")
            print(value)
            if let user = value {
                UserDefaults.standard.set(user.id ,forKey: AuthenticationKey.keyUserId)
                UserDefaults.standard.set(user.username ,forKey: AuthenticationKey.keyUserName)
                UserDefaults.standard.set(user.email ?? "",forKey: "email")
                UserDefaults.standard.set(user.type ?? "local",forKey: "type")
            }
        }
    }
    
}

// MARK: - Local Repository
extension UserLocalRepository{
    
    func login(a user : User , withAccessToken accessToken : String){
        self.user = user
        authTokenRepository.saveToken(token: accessToken)
    }
    
    func logout(){
        authTokenRepository.clearData()
        UserDefaults.standard.removeObject(forKey: AuthenticationKey.keyUserId)
        UserDefaults.standard.removeObject(forKey: AuthenticationKey.keyUserName)
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "type")
        
    }
    
    func isLoggedIn() -> Bool{
        if let token = authTokenRepository.getToken(){
            print(token)
            return true
        }
        return false
    }
}



