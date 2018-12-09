//
//  CheckoutButtonTableViewCell.swift
//  marketo
//
//  Created by Admin on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

    // Delegate
    weak var delegate: CheckoutTableViewCellDelegate?

//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    
    // TODO Moncef Ajouti IBACTION 3ala 5ater inti te5dem 3al story board ken bech nmes haja bech tet5reb
    @IBAction func didTapCheckout(_ sender: Any){
        delegate?.checkoutCellDidTapButton(self)
    }
}
