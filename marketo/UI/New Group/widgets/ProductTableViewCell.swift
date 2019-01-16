//
//  ProductTableViewCell.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell,Configurable {
    
    typealias DataType = Product
    
    @IBOutlet weak var productName : UILabel!
    @IBOutlet weak var productImage : UIImageView!
    @IBOutlet weak var bestPrice : UILabel!
    
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
        bestPrice.text = content.prices?.min(by: { (a, b) -> Bool in
            a.value>b.value
        })?.value.description ?? "no price"
    }
    

}

