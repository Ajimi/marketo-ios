//
//  SignInUserCell.swift
//  marketo
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import UIKit

class SignInUserTableViewCell: UITableViewCell, Configurable  {
    
    @IBOutlet weak var profileImage: UIImageView!
    weak var delegate: SignInUserTableViewCellDelegate?
    
    var content:String?
    
    func configure(with content: String) {
        self.content = content
        profileImage.image = UIImage(named: "user_male")
    }
    
    @IBAction func didTapSignIn(_ sender: Any){
        delegate?.didTapSignIn(self)
    }
}
