//
//  ModifyUserPassword.swift
//  marketo
//
//  Created by Admin on 1/17/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

class ModifyUserPassword {
    let userRepository : UserRepository
    init(userRepository: UserRepository = UserRepository()){
        self.userRepository = userRepository
    }
    
    func execute(password: String)  {
        
        if let user = userRepository.getUser() {
            // TODO
            userRepository.modifyPassword(password: password, id: user.id!)
        }
        
        
    }
}

