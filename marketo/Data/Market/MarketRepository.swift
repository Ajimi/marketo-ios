//
//  MarketRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class MarketRepository {
    let remoteRepository: MarketRemoteRepository
    let localRepository: MarketLocalRepository
    
    init(remoteRepository: MarketRemoteRepository = MarketRemoteRepository(), localRepository: MarketLocalRepository = MarketLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension MarketRepository {
    
}
