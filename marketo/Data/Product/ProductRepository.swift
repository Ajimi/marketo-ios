
//  ProductRepository.swift
//  marketo
//
//  Created by selim ajimi on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
protocol ProductDataSource: DataSource {
    // TODO :Add methods
    
}

class ProductRepository {
    
    // Constructor must have local data source and remote data souree
    let remoteRepository: ProductRemoteRepository
    let localRepository: ProductLocalRepository
    
    init(remoteRepository: ProductRemoteRepository = ProductRemoteRepository(), localRepository: ProductLocalRepository = ProductLocalRepository()) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
}

extension ProductRepository {
    
    func getAll(completion:@escaping (Result<Products>)->Void) {
        remoteRepository.getAll(completion: completion)
    }
    
    func getTrending(completion:@escaping (Result<Products>)->Void) {
        remoteRepository.getTrending(completion: completion)
    }
    
    
    func getDiscounted(completion:@escaping (Result<Products>)->Void) {
        remoteRepository.getDiscounted(completion: completion)
    }
    
    func getAllByType(type : Type,completion:@escaping (Result<Products>)->Void){
        remoteRepository.getAllByType(type: type, completion: completion)
    }
    
    func getAllByMark(mark : Mark,completion:@escaping (Result<Products>)->Void){
        remoteRepository.getAllByMark(mark: mark, completion: completion)
    }
    
    func getAllByTypeAndMark(type:Type,mark:Mark,completion:@escaping (Result<Products>)->Void){
        remoteRepository.getAllByTypeAndMark(type: type, mark: mark, completion: completion)
    }
}
