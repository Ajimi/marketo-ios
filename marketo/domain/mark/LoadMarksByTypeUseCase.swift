//
//  LoadMarksByType.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadMarksByTypeUseCase {
    
    let markRepository : MarkRepository
    init(markRepository: MarkRepository = MarkRepository()){
        self.markRepository = markRepository
    }
    
    func execute(typeId:String,completion:@escaping (Result<Marks>)->Void) {
        
        markRepository.getAllByType(typeId:typeId) { (response) in
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
