//
//  Basket+CoreDataProperties.swift
//  marketo
//
//  Created by Moncef Guettat on 12/8/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//
//

import Foundation
import CoreData


extension Basket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Basket> {
        return NSFetchRequest<Basket>(entityName: "Basket")
    }

    @NSManaged public var id: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var modifiedAt: String?
    @NSManaged public var userId: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Basket {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: ProductInBasket)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: ProductInBasket)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
