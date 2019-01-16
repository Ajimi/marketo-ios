//
//  LoggedInUserUseCase.swift
//  marketo
//
//  Created by Admin on 1/16/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
class LoggedInUserUseCase {
    
    let userRepository : UserRepository
    init(userRepository: UserRepository = UserRepository()){
        self.userRepository = userRepository
    }
    
    func execute() -> User? {
        return userRepository.getUser()
    }
    
}
