//
//  Repository.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

protocol DataSource {
    
    associatedtype T
    
    func getAll() -> [T]
    func get( identifier:Int ) -> T?
    func create( a:T ) -> Bool
    func update( a:T ) -> Bool
    func delete( a:T ) -> Bool
    
}
