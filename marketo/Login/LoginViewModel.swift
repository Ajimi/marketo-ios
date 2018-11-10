//
//  LoginViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
    
    func authenticate(withUsername user : String,withPassword password:String){
        print("user is : \(user) and  the password is \(password)")
    }
    
}
