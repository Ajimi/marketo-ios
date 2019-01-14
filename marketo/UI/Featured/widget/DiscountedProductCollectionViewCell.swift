//
//  DiscountedProductCollectionViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class DiscountedProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    func configure(with product: Product){
        // TODO ADD IMAGE
        image.kf.setImage(
            with: URL(string: product.image!),
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
