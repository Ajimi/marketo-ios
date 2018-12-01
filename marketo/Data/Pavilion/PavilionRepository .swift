//
//  PavilionRepository .swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class PavilionRepository {
    let remoteRepository: PavilionRemoteRepository
    let localRepository: PavilionLocalRepository
    
    init(remoteRepository: PavilionRemoteRepository = PavilionRemoteRepository(), localRepository: PavilionLocalRepository = PavilionLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension PavilionRepository {
    func getAll(completion:@escaping (Result<Pavilions>)->Void) {
        remoteRepository.getAll(completion: completion)
    }
}
