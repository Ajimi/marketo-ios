//
//  AuthTokenRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class AuthTokenRepository {
    
    var authToken : String? = UserDefaults.standard.string(forKey: AuthenticationKey.keyAccessToken) ?? nil{
        didSet{
            UserDefaults.standard.set(authToken, forKey: AuthenticationKey.keyAccessToken)
        }
    }
    
    func clearData (){
        UserDefaults.standard.removeObject(forKey: AuthenticationKey.keyAccessToken)
        authToken = nil
    }
    
}
