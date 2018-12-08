//
//  FavoriteProduct+CoreDataProperties.swift
//  
//
//  Created by Moncef Guettat on 12/2/18.
//
//

import Foundation
import CoreData


extension FavoriteProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteProduct> {
        return NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageName: String?
    

}
