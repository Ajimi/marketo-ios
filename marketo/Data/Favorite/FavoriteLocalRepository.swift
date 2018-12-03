//
//  FavoriteLocalRepository.swift
//  
//
//  Created by Othmen on 12/3/18.
//

import Foundation
import Alamofire


class FavoriteLocalRepository {
    let persistenceManager = PersistenceManager.shared
    
    func getAll(completion:@escaping (Result<FavoriteProduct>)->Void) {
//        let favoriteProducts = persistenceManager.fetch(FavoriteProduct.self)
//        if(favoriteProducts.isEmpty){
//            completion(Result(value: { () -> _ in
//                throw 
//            }))
//        }
        
    }
    
}


