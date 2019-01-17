//
//  UserNameCell.swift
//  marketo
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit
class UserNameTableViewCell: UITableViewCell, Configurable{

    
    // - TODO ADD NAME & IMAGE OUTLET
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    weak var delegate: UserNameTableViewDelegate?
    
    var profileDetail: MoreCellDetail?
    
    func configure(with content: MoreCellDetail ) {
        self.profileDetail = content
        userName.text = content.label
        // TODO load user Profile
        
    }
    
    @IBAction func didTapUsername(_ sender: Any){
        delegate?.didTapUserName(self)
    }
}

