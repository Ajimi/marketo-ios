//
//  FeatureViewModel.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class FeaturedViewModel: ViewModel {
    
    let loadProductUseCase:LoadProductUseCase = LoadProductUseCase()
    let loadTrendingProductUseCase = LoadTrendingProductUseCase()
    let loadDiscountedProductUseCase = LoadDiscountedProductUseCase()
    
    let loadCategoryUseCase = ""
    let saveProductToBaskeUseCase = ""
    
    
    
    var uiProductState =  Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiCategoryState = Dynamic<UiState<Int>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiTrendingState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiDiscountedState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    

    func updateUI() {
        uiCategoryState.value = emitUiState(showSuccess: Event(with: 1))
        
        loadAllProducts()
        loadTrendingProducts()
        loadDiscountedProducts()
    }
    
    func loadAllProducts() {
        
        self.uiProductState.value = self.emitUiState(showProgress: true)
        loadProductUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.uiProductState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiProductState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func loadTrendingProducts() {
        self.uiTrendingState.value = self.emitUiState(showProgress: true)
        loadTrendingProductUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.uiTrendingState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiTrendingState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    
    func loadDiscountedProducts() {
        self.uiDiscountedState.value = self.emitUiState(showProgress: true)
        loadDiscountedProductUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.uiDiscountedState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiDiscountedState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
}

