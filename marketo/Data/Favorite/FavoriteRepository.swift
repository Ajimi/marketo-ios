//
//  FavoriteRepository.swift
//  marketo
//
//  Created by Othmen on 12/3/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class FavoriteRepository {
    let remoteRepository: FavoriteRemoteRepository
    let localRepository: FavoriteLocalRepository
    
    init(remoteRepository: FavoriteRemoteRepository = FavoriteRemoteRepository(), localRepository: FavoriteLocalRepository = FavoriteLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension FavoriteRepository {
    
    func deleteProduct(product:FavoriteProduct,completion:@escaping (Result<Bool>)->Void){
        
        localRepository.deleteProduct(product: product, completion: completion)
        
        
    }
    
    func addProduct(product:Product,completion:@escaping (Result<Bool>)->Void){
        
        localRepository.addProduct(product: product, completion: completion)
        
    }
}
