//
//  StatByPriceMarketPriceTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class StatByPriceMarketPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var marketName: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var totol: UILabel!
    @IBOutlet weak var diff: UILabel!
    
    func configure(price : Price, unit : Price , worst : Int) {
        marketName.text = price.market?.text
        unitPrice.text = "$ " + unit.value.description
        totol.text = "$ " + price.value.description
        diff.text = "$ " + (worst - price.value).description
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
