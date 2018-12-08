//
//  ProductInBasket+CoreDataProperties.swift
//  marketo
//
//  Created by Moncef Guettat on 12/8/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductInBasket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductInBasket> {
        return NSFetchRequest<ProductInBasket>(entityName: "ProductInBasket")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var basket: Basket?

}
