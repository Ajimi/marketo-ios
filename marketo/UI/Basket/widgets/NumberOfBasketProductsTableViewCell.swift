//
//  NumberOfBasketProductsTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/9/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class NumberOfBasketProductsTableViewCell: UITableViewCell,Configurable {
    
    func configure(with content: String) {
        numberLabel.text = content
    }

    @IBOutlet weak var numberLabel: UILabel!
    
}
