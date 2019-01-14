//
//  ProductStatisticByMarket.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias ProductStatisticsByMarkets = [ProductStatisticsByMarket]

struct ProductStatisticsByMarket: Codable {
    let id:String
    let image:String
    let unitPrices: Prices
    let prices : Prices
    let total: Int
    let skippedPrices:Int
    
    
    init(id:String,image:String,unitPrices: Prices,prices : Prices,total: Int,skippedPrices:Int) {
        self.id = id
        self.image = image
        self.unitPrices = unitPrices
        self.prices = prices
        self.total = total
        self.skippedPrices = skippedPrices
    }
}
