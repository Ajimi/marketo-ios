//
//  LoadStatisticsByMakertUseCase.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadStatisticsByMarketUseCase {
    
    let statisticsRepository : StatisticsRepository
    let loadProductsFromBasketUseCase: LoadProductsFromBasketUseCase
    init(statisticsRepository: StatisticsRepository = StatisticsRepository(),
         loadProductsFromBasketUseCase: LoadProductsFromBasketUseCase = LoadProductsFromBasketUseCase()){
        self.statisticsRepository = statisticsRepository
        self.loadProductsFromBasketUseCase = loadProductsFromBasketUseCase
    }
    
    func execute(completion:@escaping (Result<[ProductStatisticsByMarket]>)->Void) {
        
        loadProductsFromBasketUseCase.execute { (result) in
            switch result {
                case .success(let products):
                    self.statisticsRepository.getProductsStatisticsByMarket(productsInBasket: products) { (response) in
                        switch response {
                        case .success(_):
                            completion(response)
                        case .failure(let error):
                            completion(Result(value : {
                                // TODO ERROR HANDLING HAPPEN HERE
                                throw error
                            }))
                        }
                        
                    }
                case .failure(let error):
                    completion(Result(value : {
                        // TODO ERROR HANDLING HAPPEN HERE
                        throw error
                    }))
                }
            }
        }    
}
