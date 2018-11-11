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

class UserRepository:UserDataSource {
    
    // Constructor must have local data source and remote data souree
    let remoteRepository: UserRemoteRepository
    let localRepository: UserLocalRepository
    
    init(remoteRepository: UserRemoteRepository = UserRemoteRepository(), localRepository: UserLocalRepository = UserLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func login(a user: User, completion:@escaping (Any)->Void){
        remoteRepository.login(a: user, completion: completion)
    }
    
    func register(a user: User, completion:@escaping (Any)->Void){
        remoteRepository.register(a: user, completion: completion)
    }
    
    func getAll(completion:@escaping (Any)->Void) -> [User] {
        return [User]()
    }
    
    func get(identifier: Int) -> User? {
        return User(fullName: "", username: "", password: "", email: "")
    }
    
    func create(a: User) -> Bool {
        return true
    }
    
    func update(a: User) -> Bool {
        return true
    }
    
    func delete(a: User) -> Bool {
        return true
    }
    
}
