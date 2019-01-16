
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
    
    func get(id : Int,completion:@escaping (Result<Product>)->Void) {
        remoteRepository.get(id:id,completion: completion)
    }
    
    func getTrending(completion:@escaping (Result<Products>)->Void) {
        remoteRepository.getTrending(completion: completion)
    }
    
    func getSimilair(id: Int, completion:@escaping (Result<Products>)->Void) {
        remoteRepository.getSimilair(id: id, completion: completion)
    }
    
    
    func getDiscounted(completion:@escaping (Result<Products>)->Void) {
        remoteRepository.getDiscounted(completion: completion)
    }
    
    func getAllByType(typeId : String,completion:@escaping (Result<Products>)->Void){
        remoteRepository.getAllByType(typeId: typeId, completion: completion)
    }
    
    func getAllByMark(markId : String,completion:@escaping (Result<Products>)->Void){
        remoteRepository.getAllByMark(markId: markId, completion: completion)
    }
    
    func getAllByTypeAndMark(typeId:String,markId:String,completion:@escaping (Result<Products>)->Void){
        remoteRepository.getAllByTypeAndMark(typeId: typeId, markId: markId, completion: completion)
    }
}
