//
//  StatisticsRemoteRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/2/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class StatisticsRemoteRepository {
    
    @discardableResult
    private func performRequest<T:Decodable>(route:StatisticsRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<[T]>)->Void) -> DataRequest {
        return AF.request(route)
            .validate(statusCode : 200..<300)
            .responseDecodable (decoder: decoder){ (response: DataResponse<[T]>) in
                completion(response.result)
        }
    }
    
    func getProductsStatisticsByPrice(productsInBasket: ProductsInBasket,completion:@escaping (Result<[ProductStatisticsByPrice]>)->Void) {
        performRequest(route: StatisticsRouter.getStatisticsByPrices(basket: productsInBasket),completion: completion)
    }
    
    func getProductStatisticByMarket(productsInBasket: ProductsInBasket,completion:@escaping (Result<[ProductStatisticsByMarket]>)->Void) {
        performRequest(route: StatisticsRouter.getStatisticsByMarkets(basket: productsInBasket),completion: completion)
    }
    
    
    //getProductsStatisticsByPrice
    //getProductStatisticByMarket
    //saveStatistics
    
}
