//
//  AuthTokenRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class AuthTokenRepository {
    
    var authToken : String? = UserDefaults.standard.string(forKey: AuthenticationKey.keyAccessToken)
    
    func clearData (){
        UserDefaults.standard.removeObject(forKey: AuthenticationKey.keyAccessToken)
        authToken = UserDefaults.standard.string(forKey: AuthenticationKey.keyAccessToken)
    }
    
    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: AuthenticationKey.keyAccessToken)
    }
    
    func getToken() -> String?{
        return UserDefaults.standard.string(forKey: AuthenticationKey.keyAccessToken)
    }
    
}
