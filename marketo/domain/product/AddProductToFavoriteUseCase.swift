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
    
    let productRepository : ProductRepository
    init(productRepository: ProductRepository = ProductRepository()){
        self.productRepository = productRepository
    }
    
    func execute(completion:@escaping (Result<Products>)->Void) {
        
    }
}

