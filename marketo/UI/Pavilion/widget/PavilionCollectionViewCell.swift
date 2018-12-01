//
//  CategoryCollectionViewCell.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class PavilionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var label : UILabel!
    
    func configure(with pavilion: Pavilion) {
        self.label.text = pavilion.name
        // TODO ADD IMAGE WITH ALAMOFIRE IMAGE
    }
    
}
