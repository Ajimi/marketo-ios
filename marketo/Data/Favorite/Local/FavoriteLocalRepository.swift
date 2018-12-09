//
//  FavoriteLocalRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 12/8/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class FavoriteLocalRepository: LocalRepository {
    
    
    
}

extension FavoriteLocalRepository{
    func getProducts(completion: (Result<FavoriteProducts>) -> Void) {
        let products = persistenceManager.fetch(FavoriteProduct.self)
        
        if(products.isEmpty){
            completion(Result{
                throw DataBaseError.EmptyError
            })
        }else{
            completion(Result{
                return products
            })
        }
    }
    
    
    func deleteProduct(product:FavoriteProduct,completion:@escaping (Result<Bool>)->Void){
        persistenceManager.delete(product)
        completion(Result{
            return true
        })
    }
    
    func addProduct(product:Product,completion:@escaping (Result<Bool>)->Void){
        
        let favorite = FavoriteProduct(context: persistenceManager.context)
        favorite.name = product.name
        favorite.imageName = product.image
        persistenceManager.save()
        completion(Result{
            return true
        })
    }
}
