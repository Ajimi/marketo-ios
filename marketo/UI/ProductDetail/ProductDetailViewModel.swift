//
//  ProductDetailViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

class ProductDetailViewModel: ViewModel {
    
    let loadSimilarProductsUseCase : LoadSimilairProductUseCase = LoadSimilairProductUseCase()
    
    let saveProductToBasketUseCase =  SaveProductToBasketUseCase()
    let addProductToFavoriteUseCase =  AddProductToFavoriteUseCase()
    let removeProductFromFavoriteUseCase = RemoveProductFromFavoriteUseCase()
    let removeProductFromBasketUseCase =  RemoveProductFromBasketUseCase()
    let isFavoriteProductUseCase = IsFavoriteProductUseCase()
    let isBasketProductUseCase = IsBasketProductUseCase()
    
    var product : Product? {
        didSet{
            loadSimilarProduct(product: product!)
        }
    }
    
    var similarProducts : Products = Products()
    
    
    var uiSimilarProductsState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiMessageState = Dynamic<UiState<String>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func updateUi(){
        
    }
    
    func loadSimilarProduct(product : Product){
        self.uiSimilarProductsState.value = self.emitUiState(showProgress: true)
        loadSimilarProductsUseCase.execute(product: product) { (response) in
            switch response {
            case .success(let products):
                self.similarProducts = products
                self.uiSimilarProductsState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiSimilarProductsState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
}

extension ProductDetailViewModel{
    
    
    func toggleProductBasket(){
        isBasketProductUseCase.execute(with: product!) { response in
            switch response {
            case .success(let isFavorite):
                if isFavorite == true {
                    self.removeFromBasket()
                } else {
                    self.addToBasket()
                }
            case .failure(let error):
                print("Error basket")
            }
        }
    }
    
    
    
    func removeFromBasket() {
        removeProductFromBasketUseCase.execute(with: product!) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product removed from Basket"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    func addToBasket(){
        saveProductToBasketUseCase.execute(product: product!) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product added to Basket"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    func toggletProductFavorite(){
        isFavoriteProductUseCase.execute(with: product!) { response in
            switch response {
            case .success(let isFavorite):
                if isFavorite == true {
                    self.removeFromFavorite()
                } else {
                    self.addToFavorite()
                }
            case .failure(let error):
                print("Error favorite")
            }
            
        }
        
    }
    
    func removeFromFavorite() {
        removeProductFromFavoriteUseCase.execute(with: product!) { response in
            switch response {
            case .success(let suc):
                self.uiMessageState.value = self.emitUiState(showSuccess: Event(with: "Product removed from favorite"))
                print(suc)
            case .failure(let error):
                self.uiMessageState.value = self.emitUiState(showError: Event(with: "OoPs"))
            }
        }
    }
    
    func addToFavorite(){
        addProductToFavoriteUseCase.execute(with: product!) { response in
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
