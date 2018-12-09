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
    var uiDeleteFavoriteProductState = Dynamic<UiState<IndexPath>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    
    
    var favoriteProducts = FavoriteProducts()
    
    
    func updateUI() {
        loadFavoriteProducts()
    }
    
    
    func loadFavoriteProducts() {
        loadFavoriteProductUseCase.execute { (response) in
            switch response {
            case .success(let products):
                self.favoriteProducts = products
                self.uiFavoriteProductState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiFavoriteProductState.value = self.emitUiState(showProgress: false, showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func removeProductFromFavorite(at indexPath: IndexPath) {
        deleteProductFromFavoriteUseCase.execute(with: favoriteProducts[indexPath.row]) { (response) in
            switch response {
            case .success(_):
                self.favoriteProducts.remove(at: indexPath.row)
                self.uiDeleteFavoriteProductState.value = self.emitUiState(showSuccess: Event(with: indexPath))
            case .failure(let error):
                print(error)
                self.uiDeleteFavoriteProductState.value = self.emitUiState(showError:Event(with: "false"))
            }
        }
    }
}
