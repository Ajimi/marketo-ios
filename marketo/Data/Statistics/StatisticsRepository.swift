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
    func getProductsStatisticsByPrice(productsInBasket: ProductsInBasket,completion:@escaping (Result<ProductStatisticsByPrices>)->Void) {
        remoteRepository.getProductStatisticByMarket(productsInBasket: productsInBasket,completion: completion)
    }
    
    func getProductStatisticByMarket(productsInBasket: ProductsInBasket,completion:@escaping (Result<ProductStatisticsByMarkets>)->Void) {
        remoteRepository.getProductsStatisticsByPrice(productsInBasket: productsInBasket,completion: completion)
    }

}
