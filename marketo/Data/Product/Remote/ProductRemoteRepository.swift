//
//  ProductRemoteRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class ProductRemoteRepository{
    
    private func performRequest(route:ProductRouter, completion:@escaping (Result<Any>)->Void){
        Alamofire.request(route)
            .responseJSON{ (response: DataResponse<Any>) in
                completion(response.result)
        }
    }
}

extension ProductRemoteRepository: ProductDataSource{
    
    func getAll(completion:@escaping (Any)->Void) -> [Product] {
        performRequest(route : ProductRouter.getAll(), completion:completion)
        return [Product]()
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
