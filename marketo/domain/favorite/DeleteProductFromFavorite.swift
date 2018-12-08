//
//  saveProductToFavourite.swift
//  marketo
//
//  Created by Othmen on 12/3/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire


class DeleteProductFromFavorite {
    
    let favoriteRepository : FavoriteRepository
    init(favoriteRepository: FavoriteRepository = FavoriteRepository()){
        self.favoriteRepository = favoriteRepository
    }
    
    func execute(with product: FavoriteProduct,completion:@escaping (Result<Bool>)->Void) {
        
        favoriteRepository.deleteProduct(product: product, completion: completion)
        
    }
}
