//
//  FavoriteRemoteRepository.swift
//  marketo
//
//  Created by Othmen on 12/3/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
class FavoriteRemoteRepository {
    
    @discardableResult
    private func performRequest<T:Decodable>(route:CategoryRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseJSONDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
    
}

extension FavoriteRemoteRepository {
    func getAll(completion:@escaping (Result<Pavilions>)->Void) { // Todo change Result<FavoriteProduct>
        performRequest(route : CategoryRouter.getAll(), completion:completion)
    }
}
