//
//  UserDataSource.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

protocol UserDataSource: DataSource {
    // TODO :Add methods
    associatedtype T
    func login(a: T) -> Bool
}
