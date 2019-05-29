//
//  Constants.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation

struct ProductionServer {
    static let baseURL = "http://41.226.11.252:11825"
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
    static let fullname = "fullName"
    static let type = "type"
}
struct APIBasketProductParameterKey {
    static let id = "productId"
    static let quantity = "quantity"
}
struct APIProductParameterKey {
    static let name = "name"
    static let prices = "prices"
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
