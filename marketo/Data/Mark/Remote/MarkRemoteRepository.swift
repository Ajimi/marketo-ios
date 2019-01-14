//
//  MarkRemoteRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class MarkRemoteRepository {
    
    @discardableResult
    private func performRequest<T:Decodable>(route:MarkRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
}

extension MarkRemoteRepository{
    
    func getAll(completion:@escaping (Result<Marks>)->Void) {
        performRequest(route : MarkRouter.getAll(), completion:completion)
    }
    
    func getAllByType(typeId: String,completion:@escaping (Result<Marks>)->Void) {
        performRequest(route : MarkRouter.getAllByType(typeId: typeId), completion:completion)
    }
    
}
