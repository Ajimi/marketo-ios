//
//  LoadProductsByTypeAndMarkUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadProductsByTypeAndMarkUseCase {
    
    let productRepository : ProductRepository
    init(productRepository: ProductRepository = ProductRepository()){
        self.productRepository = productRepository
    }
    
    func execute(typeId :String,markId : String,completion:@escaping (Result<Products>)->Void) {
        
        productRepository.getAllByTypeAndMark(typeId: typeId,markId: markId) { (response) in
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
