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
    @IBOutlet weak var productName : UILabel!
    @IBOutlet weak var marketName : UILabel!
    @IBOutlet weak var discount : UILabel!
    
    func configure(with product: Product){

        productName.text = product.name
        marketName.text = getBestDiscountPrice(product: product).market?.text
        discount.text = (getBestDiscountPrice(product: product).discount! * Float(100)).clean + "%"
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

extension DiscountedProductCollectionViewCell{
    
    func getBestDiscountPrice(product : Product) -> Price {
        
        return (product.prices?.max(by: { (price1, price2) -> Bool in
            (price2.discount?.isLess(than: price1.discount ?? 0)) ?? false
        }))!
        
    }
    
    
}
