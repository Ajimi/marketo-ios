//
//  FavoriteProduct+CoreDataProperties.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteProduct> {
        return NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
    }

    @NSManaged public var id: Int32
    @NSManaged public var imageName: String?
    @NSManaged public var name: String?

}
