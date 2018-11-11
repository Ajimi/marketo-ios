//
//  ProductViewModel.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

struct ProductData {
    let name:String?
    let price:String?
    let url: String?
}

class ProductViewModel: NSObject {
    var products = [ProductData]()
    func getProducts() -> [ProductData] {
        products += [ProductData.init(name: "selim", price: "15", url: "string")]
        products += [ProductData.init(name: "selim", price: "15", url: "string")]
        products += [ProductData.init(name: "selim", price: "15", url: "string")]
        products += [ProductData.init(name: "selim", price: "15", url: "string")]
        products += [ProductData.init(name: "selim", price: "15", url: "string")]
        return products
    }
}
