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

    var selectedMark : Mark?
    var selectedType : Type?
    
    var products : Products = Products()
    
    var uiProductsState = Dynamic<UiState<Products>>(UiState(showProgress: false, showError: nil,showSuccess: nil))
    
    func updateUI(){
        if let mark = selectedMark && let type = selectedType {
            loadProductsByTypeAndMark()
        }else if let type = selectedType{
            
        }else if let mark = selectedMark{
            
        }
    }
    
    1
    2
    3
    4
    
    
    
}
