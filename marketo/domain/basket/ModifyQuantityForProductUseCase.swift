//
//  ModifyQuantityForProductUseCase.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

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
