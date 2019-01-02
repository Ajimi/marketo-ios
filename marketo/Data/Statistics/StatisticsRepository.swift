//
//  StatisticsRepository.swift
//  marketo
//
//  Created by Moncef Guettat on 1/2/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class StatisticsRepository {
    
    let remoteRepository: StatisticsRemoteRepository
    
    init(remoteRepository: StatisticsRemoteRepository = StatisticsRemoteRepository()) {
        self.remoteRepository = remoteRepository
    }
    
}

extension StatisticsRepository {
    
}
