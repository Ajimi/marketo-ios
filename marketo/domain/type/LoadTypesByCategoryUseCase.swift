//
//  LoadTypesByCategoryUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadTypesByCategoryUseCase {
    
    let typeRepository : TypeRepository
    init(typeRepository: TypeRepository = TypeRepository()){
        self.typeRepository = typeRepository
    }
    
    func execute(category:Category, completion:@escaping (Result<Types>)->Void) {
        
        typeRepository.getAllByCategory(category: category) { (response) in
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
