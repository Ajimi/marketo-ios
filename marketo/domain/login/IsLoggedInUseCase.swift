//
//  IsLoggedInUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 12/2/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class IsLoggedInUseCase {
    
    let loginRepository : UserRepository
    init(loginRepository: UserRepository = UserRepository()){
        self.loginRepository = loginRepository
    }
    
    func execute() -> Bool{
        
        return loginRepository.isLoggedIn()
        
    }
    
}
