//
//  ProductStatisticsByPrice.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias ProductStatisticsByPrices = [ProductStatisticsByPrice]

struct ProductStatisticsByPrice :Codable{
    let id: String
    let description:String
    let image :String
    let quantity: Int
    let unitPrices: Prices
    let mark:Mark
    let type:Type
    let bestPrice: Price
    
    init(id:String, description:String, image:String, quantity:Int, unitPrices: Prices, mark:Mark, type:Type, bestPrice:Price){
        self.id = id
        self.description = description
        self.image = image
        self.quantity = quantity
        self.unitPrices = unitPrices
        self.mark = mark
        self.type = type
        self.bestPrice = bestPrice
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
