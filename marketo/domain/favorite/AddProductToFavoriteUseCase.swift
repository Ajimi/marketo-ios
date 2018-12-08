//
//  AddProductToFavourite.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
class AddProductToFavoriteUseCase {
    
    let favoriteRepository : FavoriteRepository
    init(favoriteRepository: FavoriteRepository = FavoriteRepository()){
        self.favoriteRepository = favoriteRepository
    }
    
    func execute(with product:Product,completion:@escaping (Result<Bool>)->Void) {
        favoriteRepository.addProduct(product: product){ (response) in
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

