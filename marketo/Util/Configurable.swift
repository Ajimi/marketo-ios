//
//  Configurable.swift
//  marketo
//
//  Created by Moncef Guettat on 12/1/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype DataType
    func configure(with content: DataType)
}
