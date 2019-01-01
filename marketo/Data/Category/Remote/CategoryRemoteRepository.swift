//
//  CategoryRemoteRepository.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class CategoryRemoteRepository{
    
    @discardableResult
    private func performRequest<T:Decodable>(route:CategoryRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseJSONDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
}

extension CategoryRemoteRepository{
    
    func getAll(completion:@escaping (Result<Categories>)->Void) {
        performRequest(route : CategoryRouter.getAll(), completion:completion)
    }
    
    func getAllByPavilion(pavilion: Pavilion,completion:@escaping (Result<Categories>)->Void) {
        performRequest(route : CategoryRouter.getAllByPavilion(pavilion: pavilion), completion:completion)
    }
}
