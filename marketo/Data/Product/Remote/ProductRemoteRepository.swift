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
    
    @discardableResult
    private func performRequest<T:Decodable>(route:ProductRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                print(response.result)
                completion(response.result)
        }
    }
}

extension ProductRemoteRepository{
    
    func getAll(completion:@escaping (Result<Products>)->Void) {
        performRequest(route : ProductRouter.getAll(), completion:completion)
    }
    
    func get(id : Int,completion:@escaping (Result<Product>)->Void) {
        performRequest(route : ProductRouter.get(id : id), completion:completion)
    }
    
    func getTrending(completion:@escaping (Result<Products>)->Void) {
        performRequest(route: ProductRouter.getFeatured(), completion: completion)
    }
    
    func getDiscounted(completion:@escaping (Result<Products>)->Void) {
        performRequest(route: ProductRouter.getDiscounted(), completion: completion)
    }
    
    func getAllByType(typeId : String,completion:@escaping (Result<Products>)->Void){
        performRequest(route: ProductRouter.getByType(typeId: typeId), completion: completion)
    }
    
    func getAllByMark(markId : String,completion:@escaping (Result<Products>)->Void){
        performRequest(route: ProductRouter.getByMark(markId: markId), completion: completion)
    }
    
    func getAllByTypeAndMark(typeId:String ,markId:String,completion:@escaping (Result<Products>)->Void){
        performRequest(route: ProductRouter.getByTypeAndMark(typeId: typeId, markId: markId), completion: completion)
    }
}
