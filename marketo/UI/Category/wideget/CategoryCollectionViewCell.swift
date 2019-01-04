//
//  CategoryCollectionViewCell.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell,Configurable {
    
    
    typealias DataType = Category
    
    
    @IBOutlet weak var categoryName : UILabel!
    
    
    func configure(with content: Category) {
        categoryName.text = content.name
    }
    
    
}
