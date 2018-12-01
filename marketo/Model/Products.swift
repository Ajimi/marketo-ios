//
//  Product.swift
//  marketo
//
//  Created by Moncef Guettat on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

typealias Products = [Product]

class Product: Codable {
    let id, name: String
    let priceInMarket: [PriceInMarket]
    let description: Description
    let image: String
    let createdAt, updatedAt: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, priceInMarket, description, image, createdAt, updatedAt
        case v = "__v"
    }
    
    init(id: String, name: String, priceInMarket: [PriceInMarket], description: Description, image: String, createdAt: String, updatedAt: String, v: Int) {
        self.id = id
        self.name = name
        self.priceInMarket = priceInMarket
        self.description = description
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.v = v
    }
}

enum Description: String, Codable {
    case concrete = "Concrete"
    case cotton = "Cotton"
    case fresh = "Fresh"
    case frozen = "Frozen"
    case granite = "Granite"
    case metal = "Metal"
    case plastic = "Plastic"
    case rubber = "Rubber"
    case soft = "Soft"
    case steel = "Steel"
    case wooden = "Wooden"
}

class PriceInMarket: Codable {
    let id: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price
    }
    
    init(id: String, price: Int) {
        self.id = id
        self.price = price
    }
}
