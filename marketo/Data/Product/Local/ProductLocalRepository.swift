//
//  ProductLocalRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class ProductLocalRepository{
    
    
    
    
}

extension ProductLocalRepository: ProductDataSource{
    
    
    func getAll(completion:@escaping (Any)->Void) -> [Product] {
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
