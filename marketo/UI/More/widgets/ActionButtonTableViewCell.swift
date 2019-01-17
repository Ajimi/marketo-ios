//
//  ActionButtonCell.swift
//  marketo
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class ActionButtonTableViewCell: UITableViewCell, Configurable {
    
    // - TODO ADD NAME & IMAGE OUTLET
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    weak var delegate: ActionButtonTableViewCellDelegate?
    
    var cellDetail: MoreCellDetail?
    
    func configure(with content: MoreCellDetail) {
        self.cellDetail = content
        label.text = content.label
//        icon.image =  UIImage(named: content.image)
    }
    
    func didTapActionButton(){
        delegate?.didTapActionButton(self)
    }
}
