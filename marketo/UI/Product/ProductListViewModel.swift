//
//  ProductListViewModel.swift
//  marketo
//
//  Created by Othmen on 11/26/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class ProductListViewModel: NSObject {
    
     var uiState =  Dynamic<ProductListUiModel>(ProductListUiModel(showProgress: false, showError: nil , showSuccess: nil))
    
    var products = [ProductItem]()
    
    let repository = ProductRepository()
    
    func getAllProduct(){
        emitUiState(showProgress: true)
        repository.getAll(completion: getAllResponse)
    }
    
    func getAllResponse(response : Result<ProductList>) {
        switch response {
        case .success(let products):
            print(products)
            self.emitUiState(showSuccess: Event(with: products))
        // TODO: - Check Errors
        case .failure(let error):
            //            print(error.asAFError?.responseCode as! Int)
            emitUiState(showError: Event(with: error.localizedDescription))
            print(error.localizedDescription)
        }
    }
}

extension ProductListViewModel {
    private func emitUiState(
        showProgress: Bool = false,
        showError: Event<String>? = nil,
        showSuccess: Event<ProductList>? = nil
        ) {
        
        let uiModel = ProductListUiModel(showProgress: showProgress, showError: showError, showSuccess: showSuccess)
        uiState.value = uiModel
    }
}

struct ProductListUiModel {
    var showProgress: Bool
    var showError: Event<String>?
    var showSuccess: Event<ProductList>?
}

