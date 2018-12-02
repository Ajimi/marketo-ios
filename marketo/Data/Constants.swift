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
struct AuthenticationKey{
    static let keyAccessToken = "AccessToken"
    static let keyUserId = "UserId"
    static let keyUserName = "UserName"
}
struct APIUserParameterKey {
    static let email = "email"
    static let password = "password"
    static let username = "username"
    static let fullname = "fullname"
}
struct APIProductParameterKey {
    static let name = "name"
    static let priceInMarket = "priceInMarket"
    static let description = "description"
}
struct APIPriceParameterKey {
    static let price = "price"
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
