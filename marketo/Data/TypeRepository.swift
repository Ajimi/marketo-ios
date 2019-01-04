//
//  CategoryRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class TypeRepository {
    let remoteRepository: TypeRemoteRepository
    let localRepository: TypeLocalRepository
    
    init(remoteRepository: TypeRemoteRepository = TypeRemoteRepository(), localRepository: TypeLocalRepository = TypeLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension TypeRepository {
    
    func getAll(completion:@escaping (Result<Types>)->Void) {
        remoteRepository.getAll(completion: completion)
    }
    
    func getAllByCategory(categoryId: String,completion:@escaping (Result<Types>)->Void) {
        remoteRepository.getAllByCategory(categoryId: categoryId, completion: completion)
    }
    
}
