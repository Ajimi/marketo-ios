//
//  TrendingProductCollectionViewCell.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class TrendingProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var product : Product?
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        let pers = PersistenceManager.shared
        let favorite = FavoriteProduct(context: pers.context)
        favorite.name = product?.name
        favorite.imageName = product?.image
        pers.save()
    }
    
    func configure(with product: Product){
        self.product = product
        name.text = product.name
        // TODO ADD IMAGE
    }
}
