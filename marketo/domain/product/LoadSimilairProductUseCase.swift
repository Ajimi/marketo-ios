//
//  LoadSimilaiirProductUseCase.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadSimilairProductUseCase {
    
    let productRepository : ProductRepository
    init(productRepository: ProductRepository = ProductRepository()){
        self.productRepository = productRepository
    }
    
    func execute(product: Product,completion:@escaping (Result<Products>)->Void) {
        
        productRepository.getSimilair(id: product.type?.id) { (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    // TODO ERROR HANDLING HAPPEN HERE
                    throw error
                }))
            }
            
        }
    }
}
