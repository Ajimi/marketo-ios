//
//  BasketViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 12/8/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class BasketViewModel: ViewModel{
    
    let loadProductsFromBasketUseCase = LoadProductsFromBasketUseCase()
    let deletProductFromBasktUseCase = DeleteProductFromBasketUseCase()
    let deleteAllProductFromBasketUseCase = DeleteAllProductFromBasketUseCase()
    let modifyQuantityForProductUseCase = ModifyQuantityForProductUseCase()
    let addProductUseCase =  SaveProductToBasketUseCase()
    
    
   
    var uiBasketProductsState =  Dynamic<UiState<ProductsInBasket>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiSaveProductState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiDeleteProductState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiTruncateBasketState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiModifyProductState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    var products:ProductsInBasket = ProductsInBasket()
    

    
    func updateUI() {
        loadProductsFromBasket()
    }
    
    
    func loadProductsFromBasket(){
        self.uiBasketProductsState.value = self.emitUiState(showProgress: true)
        loadProductsFromBasketUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.products = products
                self.uiBasketProductsState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiBasketProductsState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
}
