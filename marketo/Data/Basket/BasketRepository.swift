//
//  BasketRepository.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

import Alamofire
protocol BasketDataSource: DataSource {
    // TODO :Add methods
    
}

class BasketRepository {
    
    // Constructor must have local data source and remote data souree
    let remoteRepository: BasketRemoteRepository
    let localRepository: BasketLocalRepository
    
    init(remoteRepository:  BasketRemoteRepository = BasketRemoteRepository(), localRepository: BasketLocalRepository = BasketLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    
}
