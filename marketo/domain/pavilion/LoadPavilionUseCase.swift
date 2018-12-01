//
//  LoadPavilionUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire
class LoadPavilionUseCase {
    
    let pavilionRepository : PavilionRepository
    init(pavilionRepository: PavilionRepository = PavilionRepository()){
        self.pavilionRepository = pavilionRepository
    }
    
    func execute(completion:@escaping (Result<Pavilions>)->Void) {
        
        pavilionRepository.getAll { (response) in
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
