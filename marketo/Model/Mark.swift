//
//  Mark.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias Marks = [Mark]

struct Mark: Codable {
    
    let id: Int
    let name: String
    let products: Products?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, createdAt, updatedAt
        case products
    }
    
    init(id: Int,name: String,products: Products?,createdAt: String,updatedAt: String){
        self.id = id
        self.name = name
        self.products = products
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
