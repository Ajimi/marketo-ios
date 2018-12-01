//
//  CategoryHomeCollectionViewCell.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class PavilionHomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func configure(with pavilion: Pavilion){
        self.name.text = pavilion.name
        // TODO ALAMOFIRE IMAGE
    }
    
}
