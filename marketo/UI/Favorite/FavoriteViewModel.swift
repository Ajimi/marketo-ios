//
//  FavoriteViewModel.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class FavoriteViewModel: ViewModel {
    let deleteProductFromFavoriteUseCase = DeleteProductFromFavoriteUseCase()
    let loadFavoriteProductUseCase = LoadFavoriteProductUseCase()
    
    var uiFavoriteProductState =  Dynamic<UiState<FavoriteProducts>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    var uiDeleteFavoriteProductState = Dynamic<UiState<Bool>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func updateUI() {
        loadFavoriteProducts()
    }
    
    var favoriteProducts = Dynamic<FavoriteProducts>(FavoriteProducts())
    
    func loadFavoriteProducts() {
        loadFavoriteProductUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.favoriteProducts.value = products
                self.uiFavoriteProductState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiFavoriteProductState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func removeProductFromFavorite(favoriteProduct:FavoriteProduct) {
        deleteProductFromFavoriteUseCase.execute(with: favoriteProduct) { (response) in
            switch response {
            case .success(let state):
                if let index = self.favoriteProducts.value.index(of: favoriteProduct) {
                    self.favoriteProducts.value.remove(at: index)
                }
                // Update Local Value
                self.uiDeleteFavoriteProductState.value = self.emitUiState(showSuccess: Event(with: state))
            case .failure(let error):
                print(error)
                self.uiDeleteFavoriteProductState.value = self.emitUiState(showSuccess:Event(with: false))
            }
        }
    }
}
