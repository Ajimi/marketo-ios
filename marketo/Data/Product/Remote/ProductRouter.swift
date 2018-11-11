//
//  ProductRoute.swift
//  marketo
//
//  Created by Moncef Guettat on 11/11/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

enum ProductRouter : APIConfiguration {
    
    case getAll()
    case get(id : Int)
    case create(Product: Product)
    case delete(Product: Product)
    case update(Product: Product)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        case .get:
            return .get
        case .create:
            return .post
        case .delete:
            return .delete
        case .update:
            return .put
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
        case .delete(let product):
            return "/\(product.id!)"
        case .update(let product):
            return "/\(product.id!)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getAll:
            return nil
        case .create(let product):
            return  [APIProductParameterKey.name : product.name ,
                     APIProductParameterKey.description : product.description]
        case .delete:
            return nil
        case .get:
            return nil
        case .update(let product):
            return  [APIProductParameterKey.name : product.name ,
                     APIProductParameterKey.description : product.description]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/products"+path))
        
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
