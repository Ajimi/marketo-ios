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
    
    func modifyQuantity(for product: ProductInBasket, with value:Int) {
        modifyQuantityForProductUseCase.execute(for: product, with: value) { (response) in
            switch response {
            case .success(let success):
                self.uiModifyProductState.value = self.emitUiState(showSuccess: Event(with:success))
            case .failure(let error):
                print(error)
                self.uiModifyProductState.value = self.emitUiState(showError: Event(with:"message"))
            }
        }
    }
    
    func truncateBasket(){
        deleteAllProductFromBasketUseCase.execute { (response) in
            switch response {
            case .success(_):
                self.uiTruncateBasketState.value = self.emitUiState(showSuccess: Event(with:true))
            case .failure(let error):
                print(error)
                self.uiTruncateBasketState.value = self.emitUiState(showError:Event(with:"message"))
            }
        }
    }
    
}
