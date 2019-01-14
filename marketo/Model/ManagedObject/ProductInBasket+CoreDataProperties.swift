//
//  ProductInBasket+CoreDataProperties.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductInBasket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductInBasket> {
        return NSFetchRequest<ProductInBasket>(entityName: "ProductInBasket")
    }

    @NSManaged public var productId: Int32
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var basket: Basket?

}
