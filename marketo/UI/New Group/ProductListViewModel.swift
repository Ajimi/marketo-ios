//
//  ProductListViewModel.swift
//  marketo
//
//  Created by Moncef Guettat on 1/5/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

class ProductListViewModel: ViewModel {
    
    let loadProductsByMarkUseCase :LoadProductsByMarkUseCase = LoadProductsByMarkUseCase()
    let loadProductsByTypeUseCase :LoadProductsByTypeUseCase = LoadProductsByTypeUseCase()
    let loadProductsByTypeAndMarkUseCase :LoadProductsByTypeAndMarkUseCase = LoadProductsByTypeAndMarkUseCase()
    
    var products : Products = Products()
    
    var uiProductsState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func updateUI(){
        
    }
    
    
    
    
    func loadProductsByMark(mark : Mark){
        loadProductsByMarkUseCase.execute(markId: mark.id.description) { (response) in
            switch response {
            case .success(let products):
                self.products = products
                self.uiProductsState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiProductsState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func loadProductsByType(type: Type){
        loadProductsByTypeUseCase.execute(typeId: type.id.description) { (response) in
            switch response {
            case .success(let products):
                self.products = products
                self.uiProductsState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiProductsState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    func loadProductsByMarkAndType(mark: Mark,type: Type){
        loadProductsByTypeAndMarkUseCase.execute(typeId: type.id.description,markId: mark.id.description) { (response) in
            switch response {
            case .success(let products):
                self.products = products
                self.uiProductsState.value = self.emitUiState(showSuccess: Event(with: products))
            case .failure(let error):
                self.uiProductsState.value = self.emitUiState(showError: Event(with: error.localizedDescription))
            }
        }
    }
    
    
    
    
}
