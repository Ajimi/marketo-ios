//
//  Dummy.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation



class Dummy: Codable {
    let id: Int
    let name: String
    let image: String
    let description, createdAt, updatedAt: String
    let typeID, markID: Int
    let type, mark: Marke
    let prices: [Pricee]
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, description, createdAt, updatedAt
        case typeID = "typeId"
        case markID = "markId"
        case type, mark, prices
    }
    
    init(id: Int, name: String, image: String, description: String, createdAt: String, updatedAt: String, typeID: Int, markID: Int, type: Marke, mark: Marke, prices: [Pricee]) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.typeID = typeID
        self.markID = markID
        self.type = type
        self.mark = mark
        self.prices = prices
    }
}

class Marke: Codable {
    let id: Int
    let name: String?
    let createdAt, updatedAt: String
    let text: String?
    let categoryID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, createdAt, updatedAt, text
        case categoryID = "categoryId"
    }
    
    init(id: Int, name: String?, createdAt: String, updatedAt: String, text: String?, categoryID: Int?) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.text = text
        self.categoryID = categoryID
    }
}

class Pricee: Codable {
    let value: Int
    let createdAt, updatedAt: String
    let productID, marketID: Int
    let market: Marke
    
    enum CodingKeys: String, CodingKey {
        case value, createdAt, updatedAt
        case productID = "productId"
        case marketID = "marketId"
        case market
    }
    
    init(value: Int, createdAt: String, updatedAt: String, productID: Int, marketID: Int, market: Marke) {
        self.value = value
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.productID = productID
        self.marketID = marketID
        self.market = market
    }
}

