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
    let removeProductFromFavoriteUseCase = RemoveProductFromFavoriteUseCase()
    let removeProductFromBasketUseCase =  RemoveProductFromBasketUseCase()
    let isFavoriteProductUseCase = IsFavoriteProductUseCase()
    let isBasketProductUseCase = IsBasketProductUseCase()
    
    
    var loadingStateCount = 0 {
        didSet {
            if loadingStateCount == 3 {
                loadingStateCount = 0
                uiLoadingState.value = emitUiState(showProgress: false)
            } else {
                uiLoadingState.value = emitUiState(showProgress: true)
            }
        }
    }
    
    var uiProductState =  Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiPavilionsState = Dynamic<UiState<Pavilions>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiTrendingState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiDiscountedState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    var uiMessageState = Dynamic<UiState<String>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    var uiLoadingState = Dynamic<UiState<String>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
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
                self.loadingStateCount += 1
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
                self.loadingStateCount += 1
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
                self.loadingStateCount += 1
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
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product added to Basket"))
                print(suc)
            case.failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    func toggleTrendingProductBasket(at indexPath: IndexPath) {
        toggleProductBasket(product: trendingProducts[indexPath.row])
    }
    
    func toggleProductBasket(product: Product){
        isBasketProductUseCase.execute(with: product) { response in
            switch response {
            case .success(let isFavorite):
                if isFavorite == true {
                    self.removeFromBasket(product: product)
                } else {
                    self.addToBasket(product: product)
                }
            case .failure(let error):
                print("Error basket")
            }
        }
    }
  
    
    
    func removeFromBasket(product:Product) {
        removeProductFromBasketUseCase.execute(with: product) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product removed from Basket"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    func addToBasket(product:Product){
        saveProductToBasketUseCase.execute(product: product) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product added to Basket"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    
    func toggleTrendingProductFavorite(at indexPath: IndexPath) {
        toggletProductFavorite(product: trendingProducts[indexPath.row])
    }
    
    func toggletProductFavorite(product: Product){
        isFavoriteProductUseCase.execute(with: product) { response in
            switch response {
            case .success(let isFavorite):
                if isFavorite == true {
                    self.removeFromFavorite(product: product)
                } else {
                    self.addToFavorite(product: product)
                }
            case .failure(let error):
                print("Error favorite")
            }
            
        }
        
    }
    
    func removeFromFavorite(product:Product) {
        removeProductFromFavoriteUseCase.execute(with: product) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product removed from favorite"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    func addToFavorite(product:Product){
        addProductToFavoriteUseCase.execute(with: product) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product added to favorite"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
}
