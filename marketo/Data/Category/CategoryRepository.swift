//
//  CategoryRepository.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class CategoryRepository {
    let remoteRepository: CategoryRemoteRepository
    let localRepository: CategoryLocalRepository
    
    init(remoteRepository: CategoryRemoteRepository = CategoryRemoteRepository(), localRepository: CategoryLocalRepository = CategoryLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}
