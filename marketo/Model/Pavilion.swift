//
//  Pavilion.swift
//  marketo
//
//  Created by selim ajimi on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//


import Foundation

typealias Pavilions = [Pavilion]

struct Pavilion: Codable {
    
    let id: Int
    let name: String
    let image: String?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, createdAt, updatedAt
    }
    
    init(id: Int,name: String,image: String?,createdAt: String,updatedAt: String){
        self.id = id
        self.name = name
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
