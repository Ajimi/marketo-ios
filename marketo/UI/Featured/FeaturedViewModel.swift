//
//  FeatureViewModel.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class FeaturedViewModel: ViewModel {
    
    let loadPavilionUseCase:LoadPavilionUseCase = LoadPavilionUseCase()
    let loadProductUseCase:LoadProductUseCase = LoadProductUseCase()
    let loadTrendingProductUseCase = LoadTrendingProductUseCase()
    let loadDiscountedProductUseCase = LoadDiscountedProductUseCase()
    
    let saveProductToBasketUseCase =  SaveProductToBasketUseCase()
    let addProductToFavoriteUseCase =  AddProductToFavoriteUseCase()

    
    
    var uiProductState =  Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiPavilionsState = Dynamic<UiState<Pavilions>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiTrendingState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiDiscountedState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))

    var products:Products = Products()
    var pavilions:Pavilions = Pavilions()
    var trendingProducts:Products = Products()
    var discountedProducts:Products = Products()

    func updateUI() {
        loadAllPavilions()
        loadAllProducts()
        loadTrendingProducts()
        loadDiscountedProducts()
    }
    
    func loadAllPavilions() {
        
        self.uiPavilionsState.value = self.emitUiState(showProgress: true)
        loadPavilionUseCase.execute { (response) in
            switch response {
            case .success(let pavilions):
                self.pavilions = pavilions
                self.uiPavilionsState.value = self.emitUiState(showSuccess: Event(with: pavilions))
            case .failure(let error):
                self.uiPavilionsState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func loadAllProducts() {
        
        self.uiProductState.value = self.emitUiState(showProgress: true)
        loadProductUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.products = products
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
                self.trendingProducts = products
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
                self.discountedProducts = products
                self.uiDiscountedState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiDiscountedState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func addTrendingProductToBasket(at indexPath: IndexPath)  {
        saveProductToBasketUseCase.execute(product: trendingProducts[indexPath.row]) { (response) in
            switch response {
            case .success(let suc):
                print(suc)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addTrendingProductToFavorite(at indexPath: IndexPath) {
        addProductToFavoriteUseCase.execute(with: trendingProducts[indexPath.row]) { response in
            switch response {
            case .success(let suc):
                print(suc)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

