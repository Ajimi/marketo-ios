//
//  TypeRouter.swift
//  marketo
//
//  Created by Moncef Guettat on 1/1/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

enum TypeRouter: APIConfiguration{
    
    case getAll()
    case getAllByCategory(categoryId:String)
    case get(id : Int)
    
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        case .getAllByCategory:
            return .get
        case .get:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getAll:
            return ""
        case .getAllByCategory:
            return ""
        case .get(let id):
            return "/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getAll:
            return nil
        case .getAllByCategory(let categoryId):
            return ["categoryId" : categoryId]
        case .get:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/types\(path)"))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
}
