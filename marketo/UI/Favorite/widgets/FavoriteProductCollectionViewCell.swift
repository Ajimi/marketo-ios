//
//  FavoriteProductTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class FavoriteProductCollectionViewCell: UICollectionViewCell,Configurable {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var name: UILabel!
    

    weak var delegate: FavoriteProductTableViewCellDelegate?

    var favoriteProduct: FavoriteProduct?

    
    func configure(with favoriteProduct: FavoriteProduct) {
        self.favoriteProduct = favoriteProduct
        name.text = favoriteProduct.name
    }

    @IBAction func didTapRemove(_ sender: Any){
        delegate?.favoriteProductCellDidTapRemove(self)
    }
}
