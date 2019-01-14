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
    
    func getProductsStatisticsByPrice(productsInBasket: [ProductInBasket],completion:@escaping (Result<[ProductStatisticsByPrice]>)->Void) {
        let productCodable = changeToCodable(products: productsInBasket)
        performRequest(route: StatisticsRouter.getStatisticsByPrices(basket: productCodable),completion: completion)
    }
    
    func getProductsStatisticsByMarket(productsInBasket: [ProductInBasket],completion:@escaping (Result<[ProductStatisticsByMarket]>)->Void) {
        let productCodable = changeToCodable(products: productsInBasket)
        performRequest(route: StatisticsRouter.getStatisticsByMarkets(basket: productCodable),completion: completion)
    }
    
    func changeToCodable(products : [ProductInBasket]) -> [ProductInBasketCodable] {
        return products.map {  ProductInBasketCodable(productId: $0.productId.description, name: $0.name ?? "", quantity: Int($0.quantity)) }
    }
    
    
    //TODO getProductsStatisticsByPrice
    //getProductStatisticByMarket
    //saveStatistics
    
}

struct ProductInBasketCodable:Codable {
    let productId:String
    let quantity: Int
    let name:String
    	
    init(productId: String, name:String, quantity:Int) {
        self.productId = productId
        self.quantity = quantity
        self.name = name
    }
}
