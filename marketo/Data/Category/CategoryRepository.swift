//
//  CategoryRepository.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class CategoryRepository {
    let remoteRepository: CategoryRemoteRepository
    let localRepository: CategoryLocalRepository
    
    init(remoteRepository: CategoryRemoteRepository = CategoryRemoteRepository(), localRepository: CategoryLocalRepository = CategoryLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension CategoryRepository{
    func getAll(completion:@escaping (Result<Categories>)->Void) {
        remoteRepository.getAll(completion: completion)
    }
    
    func getAllByPavilion(pavilionId: String,completion:@escaping (Result<Categories>)->Void) {
        remoteRepository.getAllByPavilion(pavilionId: pavilionId, completion: completion)
    }
}
