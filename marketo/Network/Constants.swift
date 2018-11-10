//
//  Constants.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

struct ProductionServer {
    static let baseURL = "https://market-appi.herokuapp.com"
}
struct APIUserParameterKey {
    static let email = "email"
    static let password = "password"
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}
enum ContentType: String {
    case json = "application/json"
}
