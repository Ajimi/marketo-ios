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
            let userId = UserDefaults.standard.string(forKey: AuthenticationKey.keyUserId) ?? nil
            let username = UserDefaults.standard.string(forKey: AuthenticationKey.keyUserName) ?? nil
            guard userId != nil, username != nil else {
                return nil
            }
            return User(fullName: "",username: username!,password: "",email: "")
        }
        set(value) {
            if let user = value {
                UserDefaults.standard.set(user.id ,forKey: AuthenticationKey.keyUserId)
                UserDefaults.standard.set(user.username ,forKey: AuthenticationKey.keyUserName)
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
    }
    
    func isLoggedIn() -> Bool{
        if let token = authTokenRepository.getToken(){
            print(token)
            return true
        }
        return false
    }
}



