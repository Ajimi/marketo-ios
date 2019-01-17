//
//  FavoriteProductTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class FavoriteProductCollectionViewCell: UICollectionViewCell,Configurable {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    

    weak var delegate: FavoriteProductTableViewCellDelegate?

    var favoriteProduct: FavoriteProduct?

    
    func configure(with favoriteProduct: FavoriteProduct) {
        self.favoriteProduct = favoriteProduct
        name.text = favoriteProduct.name
        image.kf.setImage(
            with: URL(string: favoriteProduct.imageName!),
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }

    @IBAction func didTapRemove(_ sender: Any){
        delegate?.favoriteProductCellDidTapRemove(self)
    }
}
