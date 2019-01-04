//
//  IsFavoriteProductUseCase.swift
//  marketo
//
//  Created by Admin on 1/4/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class IsFavoriteProductUseCase {
    let favoriteRepository : FavoriteRepository
    init(favoriteRepository: FavoriteRepository = FavoriteRepository()){
        self.favoriteRepository = favoriteRepository
    }
    
    func execute(with product:Product,completion:@escaping (Result<Bool>)->Void) {
       /* favoriteRepository.isFavoriteProduct(productId: String(describing: product.id)){ (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    // TODO ERROR HANDLING HAPPEN HERE
                    throw error
                }))
            }
            
        }*/
    }
}
