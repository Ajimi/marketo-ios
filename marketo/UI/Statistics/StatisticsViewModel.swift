//
//  StatisticsViewModel.swift
//  marketo
//
//  Created by Admin on 1/14/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

class StatisticsViewModel: ViewModel {
    
    // Use Case
    let loadStatisticsByMarketUseCase: LoadStatisticsByMarketUseCase = LoadStatisticsByMarketUseCase()
    let loadStatisticsByPriceUseCase: LoadStatisticsByPriceUseCase = LoadStatisticsByPriceUseCase()
    var combinedStatCount = 0
    
    // Dynamic Data LiveData
    var uiState = Dynamic<UiState<String>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var statisticsResult: Dynamic<StatisticsResult>?{
        didSet{
            uiState.value = emitUiState(showProgress: false, showError: nil, showSuccess: Event(with: "Completed"))
        }
    }
    

    var productStatByPrice : [ProductStatisticsByPrice]? {
        didSet{
            incrementCombinedStatistics()
        }
    }
    
    var productStatByMarket : [ProductStatisticsByMarket]? {
        didSet{
            incrementCombinedStatistics()
        }
    }
    
    func incrementCombinedStatistics() {
        combinedStatCount += 1
        if combinedStatCount % 2 == 0 {
            if let statByPrice = productStatByPrice, let statByMarket = productStatByMarket {
                statisticsResult?.value = StatisticsResult(statisticsByPrice:statByPrice , statisticsByMarket: statByMarket)
            }
        }
    }
    
    func updateUI(){
        launchLoadProductsStatByPrice()
        launchLoadProductsStatByMarket()
    }
    
    
    fileprivate func launchLoadProductsStatByPrice() {
        // emit progress
        self.uiState.value = self.emitUiState(showProgress: true)
        loadStatisticsByPriceUseCase.execute { (response) in
            switch response {
            case .success(let stat):
                print(stat)
                self.productStatByPrice = stat
            case .failure(let error):
                self.uiState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
        
        // TODO call use case
        
        // TODO get result and update productStatByPrice
        // uiState
    }
    
    fileprivate func launchLoadProductsStatByMarket(){
        self.uiState.value = self.emitUiState(showProgress: true)
        loadStatisticsByMarketUseCase.execute { (response) in
            switch response {
            case .success(let stat):
                print(stat)
                self.productStatByMarket = stat
            case .failure(let error):
                self.uiState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
}

struct StatisticsResult {
    let statisticsByPrice: [ProductStatisticsByPrice]
    let statisticsByMarket: [ProductStatisticsByMarket]
}
