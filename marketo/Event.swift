//
//  Event.swift
//  marketo
//
//  Created by selim ajimi on 11/25/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

class Event<T> {
    
    var consumed = false
    private let content:T
    init(with content: T) {
        self.content = content
    }
    func consume() -> T? {
        if (consumed) {
            return nil
        } else {
            consumed = true
            return content
        }
    }
}
