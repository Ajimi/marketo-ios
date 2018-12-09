//
//  BasketProductTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class BasketProductTableViewCell: UITableViewCell,Configurable {

    func configure(with content: ProductInBasket) {
        productImage.image = UIImage(named: "")
        productName.text = content.name!
        quantity.text = Int(stepper.value).description
    }
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func deleteProduct(_ sender: Any) {
        
    }
    
    @IBAction func changeQuantity(_ sender: UIStepper) {
        quantity.text = Int(sender.value).description
    }
}
