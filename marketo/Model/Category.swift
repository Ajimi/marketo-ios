//
//  Category.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias Categories = [Category]

struct Category: Codable {
    
    let id: Int
    let name: String
    let image: String?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, createdAt, updatedAt
    }
    
    init(id: Int,name: String,image: String?,createdAt: String,updatedAt: String){
        self.id = id
        self.name = name
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
