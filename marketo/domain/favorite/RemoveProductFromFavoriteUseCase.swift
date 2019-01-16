//
//  RemoveProductFromFavoriteUseCase.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
class RemoveProductFromFavoriteUseCase {
    
    let favoriteRepository : FavoriteRepository
    init(favoriteRepository: FavoriteRepository = FavoriteRepository()){
        self.favoriteRepository = favoriteRepository
    }
    
    func execute(with product: Product,completion:@escaping (Result<Bool>)->Void) {
        favoriteRepository.removeProduct(productId: product.id) { response in
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
