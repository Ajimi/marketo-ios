//
//  BasketProductTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class BasketProductTableViewCell: UITableViewCell,Configurable{
    
    // Delegate
    weak var delegate: BasketProducTableViewCellDelegate?

    var product: ProductInBasket? // Check if weak works
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!

    
    
    func configure(with product: ProductInBasket) {
        self.product = product

        productImage.image = UIImage(named: "") // Todo get Image
        productName.text = product.name!
        quantity.text = Int(stepper.value).description
        productImage.kf.setImage(
            with: URL(string: product.image!),
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    
    @IBAction func deleteProduct(_ sender: Any) {
        
        delegate?.basketCellDidTapRemove(self)
    }
    
    @IBAction func changeQuantity(_ sender: UIStepper) {
        let number = Int(sender.value)
        quantity.text = number.description
        delegate?.basketCellDidTapStepper(self, number)
    }
}
