//
//  SignInUserCell.swift
//  marketo
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class SignInUserTableViewCell: UITableViewCell, Configurable  {
    
    weak var delegate: SignInUserTableViewCellDelegate?
    
    var content:String?
    
    func configure(with content: String) {
        self.content = content
        
    }
    
    @IBAction func didTapSignIn(_ sender: Any){
        delegate?.didTapSignIn(self)
    }
}
