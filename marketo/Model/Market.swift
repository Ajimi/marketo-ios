//
//  Market.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation

typealias Markets = [Market]

class Market: Codable {
    
    let id: Int
    let text: String
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, text, createdAt, updatedAt
    }
    
    init(id: Int,text: String,createdAt: String,updatedAt: String){
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
