//
//  PavilionRemoteRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class PavilionRemoteRepository{
    
    @discardableResult
    private func performRequest<T:Decodable>(route:PavilionRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
}

extension PavilionRemoteRepository{
    
    func getAll(completion:@escaping (Result<Pavilions>)->Void) {
        performRequest(route : PavilionRouter.getAll(), completion:completion)
    }
}
