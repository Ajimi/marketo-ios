//
//  User.swift
//  marketo
//
//  Created by Moncef Guettat on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

struct User: Codable {
    var fullName : String?
    var username : String?
    var password : String?
    var id       : Int?
    var email    : String?
    var type     : String?
    var createdAt: String?
    var updatedAt: String?
    
    init(fullName : String? = "", username : String? = "",password : String? = "", email:String? = "",type : String? = "") {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.email = email
        self.type = type
    }
    
    init(fullName : String? = "", username : String? = "",password : String? = "", email:String? = "",type : String? = "", id: Int = 9) {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.email = email
        self.type = type
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email, createdAt, updatedAt
        case fullName
        case password
        case username
        case type
    }
}

