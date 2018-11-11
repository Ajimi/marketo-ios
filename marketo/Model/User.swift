//
//  User.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class User{
    
    var fullName : String
    var username : String
    var password : String
    var email : String
    
    init(fullName : String = "", username : String = "" ,password : String = "", email:String = "") {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.email = email
    }
}
