//
//  TypeCollectionViewCell.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell,Configurable {
    
    typealias DataType = Type
    
    @IBOutlet weak var typeName : UILabel!
    
    func configure(with content: Type) {
        typeName.text = content.name
    }
    
}
