//
//  LoadProductUseCase`.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
class LoadProductUseCase {
    
    let productRepository : ProductRepository
    init(productRepository: ProductRepository = ProductRepository()){
        self.productRepository = productRepository
    }
    
    func execute(completion:@escaping (Result<Products>)->Void) {
        
        productRepository.getAll { (response) in
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
