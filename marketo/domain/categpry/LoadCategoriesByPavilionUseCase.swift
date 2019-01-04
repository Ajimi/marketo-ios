//
//  LoadCategoriesByPavilionUseCase.swift
//  marketo
//
//  Created by Moncef Guettat on 1/3/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

class LoadCategoriesByPavilionUseCase {
    
    let categoryRepository : CategoryRepository
    init(categoryRepository: CategoryRepository = CategoryRepository()){
        self.categoryRepository = categoryRepository
    }
    
    func execute(pavilion : Pavilion,completion:@escaping (Result<Categories>)->Void) {
        
        categoryRepository.getAllByPavilion(pavilion: pavilion) { (response) in
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
