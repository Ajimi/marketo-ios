//
//  LoadProductFromUseCase.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

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
