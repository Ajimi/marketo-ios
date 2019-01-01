//
//  Type.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias Types = [Type]

class Type: Codable {
    
    let id: Int
    let name: String
    let products : Products?
    let categoryId : Int?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, createdAt, updatedAt
        case categoryId = "categoryId"
        case products
    }
    
    init(id: Int,name: String,products: Products?,categoryId : Int?,createdAt: String,updatedAt: String){
        self.id = id
        self.name = name
        self.products = products
        self.categoryId = categoryId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
