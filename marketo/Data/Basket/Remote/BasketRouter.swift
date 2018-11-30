//
//  BasketRouter.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

enum BasketRouter{
    
    case getAll()
    case get(id : Int)
    case create(basket: Basket)
    case update(basket: Basket)
    case delete(basket: Basket)
    
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        case .get:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getAll:
            return ""
        case .get(let id):
            return "/\(id)"
        case .create:
            return ""
        case .update(let basket):
            return "/\(basket)"
        case .delete(let basket):
            return "/\(basket)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getAll:
            return nil
        case .get:
            return nil
        case .create:
            return nil
        case .update:
            return nil
        case .delete:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/basket\(path)"))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}
