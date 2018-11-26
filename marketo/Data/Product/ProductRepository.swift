
//  ProductRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
protocol ProductDataSource: DataSource {
    // TODO :Add methods
    
}

class ProductRepository {
    
    // Constructor must have local data source and remote data souree
    let remoteRepository: ProductRemoteRepository
    let localRepository: ProductLocalRepository
    
    init(remoteRepository: ProductRemoteRepository = ProductRemoteRepository(), localRepository: ProductLocalRepository = ProductLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    
}

extension ProductRepository {
    
    func getAll(completion:@escaping (Result<ProductList>)->Void) {
        remoteRepository.getAll(completion: completion)
    }
}
