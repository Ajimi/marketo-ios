//
//  StatByMarketProductPricesTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 1/15/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class StatByMarketProductPricesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    func configure(priceParam : Price , unitPriceParam : Price){
        if let dis = unitPriceParam.discount{
            marketName.textColor = UIColor.green
            unitPrice.textColor = UIColor.green
            price.textColor = UIColor.green
            marketName.text = priceParam.product!.name + " " + dis.percentage
        }else{
            marketName.text = priceParam.product!.name
        }
        unitPrice.text = "$ " + unitPriceParam.value.description
        price.text = "$ " + priceParam.value.description
        quantity.text = priceParam.quantity?.description
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
