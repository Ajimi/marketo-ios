//
//  ProductCellViewModel.swift
//  marketo
//
//  Created by Othmen on 11/26/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

protocol CellConfiguraable {
    func setup(viewModel: RowViewModel) // Provide a generic function
}

protocol RowViewModel {
}

class ProductCellViewModel {
   
    
    var product: Product
    let repository = ProductRepository()
    
    init(with product:Product) {
        self.product = product
    }
    
    func addToFavourite(){
        print("Favourite Add")
        // TODO call to repository
//        repository.addToFavourite()
    }
}
