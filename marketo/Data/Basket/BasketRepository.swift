//
//  BasketRepository.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

import Alamofire

class BasketRepository {
    // Constructor must have local data source and remote data souree
    let remoteRepository: BasketRemoteRepository
    let localRepository: BasketLocalRepository
    
    init(remoteRepository:  BasketRemoteRepository = BasketRemoteRepository(), localRepository: BasketLocalRepository = BasketLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension BasketRepository{
    func createBasket(completion : (Result<Basket>) -> Void)  {
        localRepository.createBasket(completion: completion)
    }
    
    func getBasket(completion:@escaping (Result<Basket>)->Void) {
        localRepository.getBasket(completion)
    }
    
    func getProductsInBasket(completion:@escaping (Result<ProductsInBasket>)->Void) {
        localRepository.getProductsInBasket(completion: completion)
    }
    
    func deleteProduct(product:ProductInBasket,completion:@escaping (Result<Bool>)->Void){
        localRepository.deleteProduct(product: product, completion: completion)
    }
    
    func removeProduct(productId:Int,completion:@escaping (Result<Bool>)->Void){
        localRepository.removeProduct(productId: productId, completion: completion)
    }
    
    func isBasketProduct(productId:Int,completion:@escaping (Result<Bool>)->Void){
        localRepository.isBasketProduct(productId: productId, completion: completion)
    }
    
    func deleteAll(completion:@escaping (Result<Bool>)->Void){
        localRepository.deleteAll(completion: completion)
    }
    
    func addProduct(product:Product,completion:@escaping (Result<Bool>)->Void){
        localRepository.addProduct(product: product, completion: completion)
    }
    
    func modifyProductQuantity(for product:ProductInBasket,with value:Int,completion:@escaping (Result<Bool>)->Void){
        localRepository.modifyProductQuantity(for: product, with: value, completion: completion)
    }
}
