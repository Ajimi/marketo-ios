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
    
    func execute(product: Product, completion:@escaping(Result<Bool>) -> Void ){
        
        basketRepository.addProduct(product: product){ (response) in
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




