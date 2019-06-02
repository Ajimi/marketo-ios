//
//  Price.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias Prices = [Price]

class Price: Codable {
    
    let value: Float
    let market: Market?
    let product: Product?
    let quantity: Int?
    let productId : Int?
    let discount: Float?
    let marketId : Int?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case value, createdAt, updatedAt, discount
        case productId = "productId"
        case marketId = "marketId"
        case market
        case product
        case quantity
    }
    
    init(value: Float,market: Market?,product: Product?,quantity: Int?,productId: Int?,marketId: Int?,discount: Float? ,createdAt: String,updatedAt: String){
        self.value = value
        self.market = market
        self.product = product
        self.quantity = quantity
        self.productId = productId
        self.marketId = marketId
        self.discount = discount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
}
