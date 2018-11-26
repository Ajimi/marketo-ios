//
//  Product.swift
//  marketo
//
//  Created by Moncef Guettat on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

struct Product{
    
    var id : Int?
    var name : String?
    var priceInMarket : [Price]?
    var description : String?
    
    init(id:Int,name: String,priceInMarket : [Price],description : String) {
        self.id = id
        self.name = name
        self.priceInMarket = priceInMarket
        self.description = description
    }
    
   
    
    
}

struct ProductList: Codable {
    let total, limit, skip: Int
    let data: [ProductItem]
}

struct ProductItem: Codable {
    let id, name: String
    let priceInMarket: [PriceInMarket]
    let description: String
    let image: String
    let createdAt, updatedAt: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, priceInMarket, description, image, createdAt, updatedAt
        case v = "__v"
    }
}

struct PriceInMarket: Codable {
    let id: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price
    }
}
