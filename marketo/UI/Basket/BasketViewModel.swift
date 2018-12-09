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
    let saveProductToBasketUseCase =  SaveProductToBasketUseCase()
    let loadBasketUseCase = LoadBasktUseCase()
    
   
    var uiBasketProductsState =  Dynamic<UiState<ProductsInBasket>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiSaveProductState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiDeleteProductState = Dynamic<UiState<IndexPath>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiTruncateBasketState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiModifyProductState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    var products:ProductsInBasket = ProductsInBasket() // change it to dynamic
    var basket: Basket = Basket() // Change it to dynamic
    
    func updateUI() {
        loadProductsFromBasket()
        loadBasket()
    }
    
    func loadProductsFromBasket(){
        self.uiBasketProductsState.value = self.emitUiState(showProgress: true)
        loadProductsFromBasketUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.products = products
                self.uiBasketProductsState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiBasketProductsState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func loadBasket() {
        loadBasketUseCase.execute { (response) in
            switch response {
            case .success(let basket):
                self.basket = basket
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteProductFromBasket(at indexPath:IndexPath) {
        deletProductFromBasktUseCase.execute(productInBasket: products[indexPath.row]) { (response) in
            switch response {
            case .success(let state):
                print(state)
                self.products.remove(at: indexPath.row)
                self.uiDeleteProductState.value = self.emitUiState(showSuccess: Event(with: indexPath))

            case .failure(let error):
                print(error)
                self.uiDeleteProductState.value = self.emitUiState(showError:Event(with: "Error happened"))
            }
        }
    }
    
    func modifyQuantity(at indexPath: IndexPath, with value:Int) {
        modifyQuantityForProductUseCase.execute(for: products[indexPath.row], with: value) { (response) in
            switch response {
            case .success(let state):
                self.uiModifyProductState.value = self.emitUiState(showSuccess: Event(with:state))
            case .failure(let error):
                print(error)
                self.uiModifyProductState.value = self.emitUiState(showError: Event(with:"Error happened"))
            }
        }
    }
    
    func truncateBasket(){
        deleteAllProductFromBasketUseCase.execute { (response) in
            switch response {
            case .success(_):
                self.products.removeAll()
                self.uiTruncateBasketState.value = self.emitUiState(showSuccess: Event(with:true))
            case .failure(let error):
                print(error)
                self.uiTruncateBasketState.value = self.emitUiState(showError:Event(with:"Error Happened"))
            }
        }
    }
    
   
    
    
}

extension BasketViewModel{
    
    func numberOfItem() -> String {
        var word: String
        let count = products.count
        switch count {
        case 0:
            word = "NO ITEMS IN BASKET"
        case 1:
            word = "1 ITEM"
        default:
            word = "\(count) ITEMS"
        }
        
        return word
    }
}
