//
//  MarkTableViewCell.swift
//  marketo
//
//  Created by Othmen on 12/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import UIKit

class MarkTableViewCell: UITableViewCell,Configurable {
    
    typealias DataType = Mark
    
    @IBOutlet weak var markName : UILabel!

    func configure(with content: Mark) {
        markName.text = content.name
    }
    
}
