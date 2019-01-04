//
//  TypeRemoteRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class TypeRemoteRepository {
    
    @discardableResult
    private func performRequest<T:Decodable>(route:TypeRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseJSONDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
}

extension TypeRemoteRepository{
    func getAll(completion:@escaping (Result<Types>)->Void) {
        performRequest(route : TypeRouter.getAll(), completion:completion)
    }
    
    func getAllByCategory(categoryId: String,completion:@escaping (Result<Types>)->Void) {
        performRequest(route : TypeRouter.getAllByCategory(categoryId: categoryId), completion:completion)
    }
}
