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
    var id       : String?
    var email    : String?
    var createdAt: String?
    var updatedAt: String?
    var v: Int?
    
    init(fullName : String = "", username : String = "" ,password : String = "", email:String = "") {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.email = email
        self.id = ""
        self.createdAt = ""
        self.v = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email, createdAt, updatedAt
        case v = "__v"
        case fullName
        case password
        case username
    }
}

