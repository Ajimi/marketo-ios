//
//  RemoveProductFromBasketUseCase.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class RemoveProductFromBasketUseCase {
    
    let basketRepository : BasketRepository
    init(basketRepository: BasketRepository = BasketRepository()){
        self.basketRepository = basketRepository
    }
    
    func execute(with product: Product,completion:@escaping (Result<Bool>)->Void) {
        basketRepository.removeProduct(productId: product.id){ (response) in
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
