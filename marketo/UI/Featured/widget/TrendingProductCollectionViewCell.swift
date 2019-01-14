//
//  TrendingProductCollectionViewCell.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class TrendingProductCollectionViewCell: UICollectionViewCell,Configurable {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var product : Product?
    
    // Delegate
    weak var delegate: TrendingProductCollectionViewCellDelegate?
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        delegate?.trendingCellDidTapFavorite(self)
    }
    
    
    @IBAction func addToBasket(_ sender: UIButton) {
        delegate?.trendingCellDidTapBasket(self)
    }
    
    func configure(with product: Product){
        self.product = product	
        name.text = product.name
        
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
