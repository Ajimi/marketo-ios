//
//  FavoriteProductTableViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class FavoriteProductTableViewCell: UITableViewCell,Configurable {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var name: UILabel!
    

    weak var delegate: FavoriteProductTableViewCellDelegate?

    var favoriteProduct: FavoriteProduct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with favoriteProduct: FavoriteProduct) {
        self.favoriteProduct = favoriteProduct
        name.text = favoriteProduct.name
    }

    // TODO: MONCEF IB ACTION BRAS MIMTEK
    @IBAction func didTapRemove(_ sender: Any){
        delegate?.favoriteProductCellDidTapRemove(self)
    }
}
