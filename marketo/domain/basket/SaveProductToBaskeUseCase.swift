//
//  SaveProductToBaskeUseCase.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class SaveProductToBasketUseCase {
    
    let basketRepository : BasketRepository
    init(basketRepository: BasketRepository = BasketRepository()){
        self.basketRepository = basketRepository
    }
    
    func execute(productInBasket: ProductInBasket, completion:@escaping(Result<Bool>) -> Void ){
        basketRepository.addProduct(product: productInBasket){ (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result{
                    throw error
                })
            }
        }
    }
}

class LoadProductsFromBasketUseCase {
    
    let basketRepository : BasketRepository
    init(basketRepository: BasketRepository = BasketRepository()){
        self.basketRepository = basketRepository
    }
    
    func execute(completion:@escaping (Result<ProductsInBasket>)->Void) {
        basketRepository.getProductsInBasket{ (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    throw error
                }))
            }
        }
    }
}

class DeleteProductFromBasketUseCase {
    
    let basketRepository : BasketRepository
    init(basketRepository: BasketRepository = BasketRepository()){
        self.basketRepository = basketRepository
    }
    
    func execute(productInBasket: ProductInBasket,completion:@escaping (Result<Bool>)->Void) {
        basketRepository.deleteProduct(product: productInBasket){ (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    throw error
                }))
            }
        }
    }
}

class DeleteAllProductFromBasketUseCase {
    let basketRepository : BasketRepository
    init(basketRepository: BasketRepository = BasketRepository()){
        self.basketRepository = basketRepository
    }
    
    func execute(completion:@escaping (Result<Bool>)->Void) {
        basketRepository.deleteAll { (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    throw error
                }))
            }
        }
    }
}

class ModifyQuantityForProductUseCase {
    let basketRepository : BasketRepository
    init(basketRepository: BasketRepository = BasketRepository()){
        self.basketRepository = basketRepository
    }
    
    func execute(for productInBasket: ProductInBasket,with newValue: Int , completion:@escaping(Result<Bool>) -> Void) {
        basketRepository.modifyProductQuantity(for: productInBasket,with: newValue) { (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    throw error
                }))
            }
        }
    }
}
