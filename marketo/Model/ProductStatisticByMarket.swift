//
//  ProductStatisticByMarket.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias ProductStatisticsByMarkets = [ProductStatisticsByMarket]

class ProductStatisticsByMarket: Codable {
    let id: Int?
    let name: String?
    let unitPrices: [Price]?
    let prices: [Price]?
    let total: Int?
    let skippedPrices: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case unitPrices = "unitPrices"
        case prices = "prices"
        case total = "total"
        case skippedPrices = "skipped_prices"
    }
    
    init(id: Int?, name: String?, unitPrices: [Price]?, prices: [Price]?, total: Int?, skippedPrices: Int?) {
        self.id = id
        self.name = name
        self.unitPrices = unitPrices
        self.prices = prices
        self.total = total
        self.skippedPrices = skippedPrices
    }
}
