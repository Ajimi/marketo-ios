//
//  Product.swift
//  marketo
//
//  Created by Moncef Guettat on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class Product {
    
    var id : Int?
    var name : String
    var priceInMarket : [Price]
    var description : String
    
    init(id:Int,name: String,priceInMarket : [Price],description : String) {
        self.id = id
        self.name = name
        self.priceInMarket = priceInMarket
        self.description = description
    }
    
}
