//
//  LoadTypesUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadTypesUseCase {
    
    let typeRepository : TypeRepository
    init(typeRepository: TypeRepository = TypeRepository()){
        self.typeRepository = typeRepository
    }
    
    func execute(completion:@escaping (Result<Types>)->Void) {
        
        typeRepository.getAll { (response) in
            switch response {
            case .success(_):
                completion(response)
            case .failure(let error):
                completion(Result(value : {
                    // TODO ERROR HANDLING HAPPEN HERE
                    throw error
                }))
            }
            
        }
    }
    
}
