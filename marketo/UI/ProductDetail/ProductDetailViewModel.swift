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
    
    var product : Product? {
        didSet{
            loadSimilarProduct(product: product!)
        }
    }
    
    var similarProducts : Products = Products()
    
    
    var uiSimilarProductsState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func updateUi(){
        
    }
    
    func loadSimilarProduct(product : Product){
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
