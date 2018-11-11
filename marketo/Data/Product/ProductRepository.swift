
//  ProductRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
	
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

extension ProductRepository: ProductDataSource{
    
    func getAll(completion:@escaping (Any)->Void) -> [Product] {
        remoteRepository.getAll(completion: completion)
        return [Product]()
        //remoteRepository.getAll()
    }
    
    func get(identifier: Int) -> Product? {
        return nil
        //remoteRepository.get(identifier: 1)
    }
    
    func create(a: Product) -> Bool {
        return true
        //remoteRepository.create(a: Product())
    }
    
    func update(a: Product) -> Bool {
        return true
        //remoteRepository.update(a: Product())
    }
    
    func delete(a: Product) -> Bool {
        return true
        //remoteRepository.delete(a: Product())
    }
}
