//
//  UserRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

protocol UserDataSource: DataSource {
    // TODO :Add methods
    
}

class UserRepository {
    
    // Constructor must have local data source and remote data souree
    let remoteRepository: UserRemoteRepository
    let localRepository: UserLocalRepository
    
    init(remoteRepository: UserRemoteRepository = UserRemoteRepository(), localRepository: UserLocalRepository = UserLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func login(a user: User, completion:@escaping (Result<AccessToken>)->Void){
        // TO DO : add Error handling and
        
        remoteRepository.login(a: user) { (result) in
            switch result {
            case .success(let accessToken):
                self.localRepository.login(a: user, withAccessToken: accessToken.accessToken)
                completion(result)
            case .failure(let error):
                // TO DO : Error handling here
                completion(result)
                print("\(error.localizedDescription)")
            }
        }
        // TO DO : add to local
        
    }
    
    func loginSocialMedia(with type : String, withAccessToken accessToken : String){
        
        localRepository.login(a: User(fullName: "", username: "", password: "", email: "") , withAccessToken: accessToken)
        
    }
    
    func register(a user: User, completion:@escaping (Result<User>)->Void){
        remoteRepository.register(a: user, completion: completion)
    }
    
    func loggedOut() -> Bool {
        localRepository.logout()
        return true
    }
    
    func isLoggedIn() -> Bool {
        return localRepository.isLoggedIn()
    }
    
}
