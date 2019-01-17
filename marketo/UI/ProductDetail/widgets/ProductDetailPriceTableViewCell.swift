//
//  ProductDetailPriceTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class ProductDetailPriceTableViewCell: UITableViewCell,Configurable {
    
    typealias DataType = Price
    
    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discount: UILabel!
    
    func configure(with content: Price) {
        marketName.text = content.market?.text
        if let disc = content.discount{
            price.text = "$ " + content.value.description + " -> " + calculateDiscount(price: content)
            discount.text = (disc * Float(100)).clean
        }else{
            price.text = "$ " + content.value.description
            discount.text = " - "
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ProductDetailPriceTableViewCell{
    func calculateDiscount(price : Price) -> String {
        let newPrice = Float(price.value) - (Float(price.value) * price.discount!)
        return "$ " + newPrice.clean
    }
}
