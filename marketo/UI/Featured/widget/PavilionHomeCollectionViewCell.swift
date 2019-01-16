//
//  CategoryHomeCollectionViewCell.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView

class PavilionHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with pavilion: Pavilion){
        
        self.name.text = pavilion.name
        image.kf.setImage(
            with: URL(string: pavilion.image!),
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        // TODO ALAMOFIRE IMAGE
    }
    
}
