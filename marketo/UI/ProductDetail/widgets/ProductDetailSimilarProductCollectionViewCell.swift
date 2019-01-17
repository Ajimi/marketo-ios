//
//  ProductDetailSimilarProductCollectionViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class ProductDetailSimilarProductCollectionViewCell: UICollectionViewCell,Configurable {
    
    
    typealias DataType = Product
    
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    
    func configure(with content: Product) {
        productName.text = content.name
        productImage.kf.setImage(
            with: URL(string: content.image!),
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}
