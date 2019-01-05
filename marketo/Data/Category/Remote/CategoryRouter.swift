//
//  CategoryRouter.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

enum CategoryRouter : APIConfiguration {
    
    case getAll()
    case getAllByPavilion(pavilionId:String)
    case get(id : Int)
    
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        case .getAllByPavilion:
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
        case .getAllByPavilion:
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
        case .getAllByPavilion(let id):
            return ["pavilionId" : id]
        case .get:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/categories\(path)"))
        
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
            }
        }
        return urlRequest
    }
    
}
