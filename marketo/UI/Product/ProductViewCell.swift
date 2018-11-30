//
//  ProductViewCell.swift
//  marketo
//
//  Created by Othmen on 11/26/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class ProductViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    
    private var viewModel: ProductCellViewModel!
    
    @IBAction func addToFavourite(_ sender: Any) {
        // viewModel.addToFavourite()
        print(viewModel.product.name)
    }
    
    
    func configure(withViewModel viewModel: ProductCellViewModel){
        self.viewModel = viewModel
        
        print("Configured  \(viewModel.product.name)")
        nameProduct.text = viewModel.product.name
        print("\(String(describing: viewModel.product.priceInMarket.first?.price))")
        if let price = viewModel.product.priceInMarket.first?.price {
            priceProduct.text = String(describing: price)
        }
    }
}
