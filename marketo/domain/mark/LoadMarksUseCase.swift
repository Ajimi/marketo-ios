//
//  LoadMarksUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadMarksUseCase {
    
    let markRepository : MarkRepository
    init(markRepository: MarkRepository = MarkRepository()){
        self.markRepository = markRepository
    }
    
    func execute(completion:@escaping (Result<Marks>)->Void) {
        
        markRepository.getAll { (response) in
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
