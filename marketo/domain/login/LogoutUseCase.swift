//
//  LogoutUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LogoutUseCase {
    let userRepository : UserRepository
    init(userRepository: UserRepository = UserRepository()){
        self.userRepository = userRepository
    }
    
    func execute() -> Bool {
        
        return userRepository.loggedOut()
    }
}
