//
//  ProductStatisticsByPrice.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias ProductStatisticsByPrices = [ProductStatisticsByPrice]

class ProductStatisticsByPrice : Codable {
    let id: Int?
    let name: String?
    let image: String?
    let description: String?
    let type: Mark?
    let mark: Mark?
    let quantity: Int?
    let unitPrices: [Price]?
    let bestPrice: Price?
    let prices: [Price]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case description = "description"
        case type = "type"
        case mark = "mark"
        case quantity = "quantity"
        case unitPrices = "unitPrices"
        case bestPrice = "bestPrice"
        case prices = "prices"
    }
    
    init(id: Int?, name: String?, image: String?, description: String?, type: Mark?, mark: Mark?, quantity: Int?, unitPrices: [Price]?, bestPrice: Price?, prices: [Price]?) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.type = type
        self.mark = mark
        self.quantity = quantity
        self.unitPrices = unitPrices
        self.bestPrice = bestPrice
        self.prices = prices
    }
}


/*
 @PrimaryKey(autoGenerate = true)
 @SerializedName("id")
 val id: String,
 @SerializedName("description")
 val description: String,
 @SerializedName("image")
 val image: String,
 @SerializedName("name")
 val name: String,
 @SerializedName("quantity")
 val quantity: Int,
 @SerializedName("unitPrices")
 val unitPrices: List<Price>,
 @SerializedName("prices")
 val prices: List<Price>,
 @SerializedName("mark")
 val mark: Mark,
 @SerializedName("type")
 val type: Type,
 @SerializedName("bestPrice")
 val bestPrice: Price
 */
