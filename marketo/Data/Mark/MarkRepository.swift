//
//  MarkRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class MarkRepository {
    let remoteRepository: MarkRemoteRepository
    let localRepository: MarkLocalRepository
    
    init(remoteRepository: MarkRemoteRepository = MarkRemoteRepository(), localRepository: MarkLocalRepository = MarkLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension MarkRepository {
    
    func getAll(completion:@escaping (Result<Marks>)->Void) {
        remoteRepository.getAll(completion: completion)
    }
    
    func getAllByType(type: Type,completion:@escaping (Result<Marks>)->Void) {
        remoteRepository.getAllByType(type: type, completion: completion)
    }
    
}
