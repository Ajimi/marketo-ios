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
    
    let id : Int
    let name: String
    let prices: Prices?
    let description: String
    let image: String?
    let typeId: Int?
    let markId: Int?
    let type: Type?
    let mark: Mark?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        
        case id, name, image, description, createdAt, updatedAt
        case typeId = "typeId"
        case markId = "markId"
        case type, mark, prices
    }
    
    init(id: Int, name: String, prices: Prices?, description: String, image: String,typeId: Int?,markId: Int?, type: Type?, mark: Mark?,createdAt: String, updatedAt: String) {
        self.id = id
        self.name = name
        self.prices = prices
        self.description = description
        self.image = image
        self.typeId = typeId
        self.markId = markId
        self.type = type
        self.mark = mark
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}











