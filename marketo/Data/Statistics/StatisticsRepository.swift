//
//  StatisticsRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/2/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class StatisticsRepository {
    
    let remoteRepository: StatisticsRemoteRepository
    
    init(remoteRepository: StatisticsRemoteRepository = StatisticsRemoteRepository()) {
        self.remoteRepository = remoteRepository
    }
    
}

extension StatisticsRepository {
    func getProductsStatisticsByPrice(productsInBasket: ProductsInBasket,completion:@escaping (Result<[ProductStatisticsByPrice]>)->Void) {
        remoteRepository.getProductsStatisticsByPrice(productsInBasket: productsInBasket,completion: completion)
    }
    
    func getProductsStatisticsByMarket(productsInBasket: ProductsInBasket,completion:@escaping (Result<[ProductStatisticsByMarket]>)->Void) {
        remoteRepository.getProductsStatisticsByMarket(productsInBasket: productsInBasket,completion: completion)
    }

}
