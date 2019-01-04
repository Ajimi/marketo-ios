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
    case getFeatured()
    case getDiscounted()
    case getByType(typeId: String)
    case getByMark(markId: String)
    case getByTypeAndMark(typeId: String,markId: String)
    case get(id : Int)
    
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        case .get:
            return .get
        case .getFeatured:
            return .get
        case .getDiscounted:
            return .get
        case .getByType:
            return .get
        case .getByMark:
            return .get
        case .getByTypeAndMark:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getAll:
            return ""
        case .get(let id):
            return "/\(id)"
        case .getFeatured:
            return "" // TODO CHANGE THE PATH featureds
        case .getDiscounted:
            return "" // TODO CHANGE THE PATH TO discounted
        case .getByType(let typeId):
            return "?typeId=\(typeId)"
        case .getByMark(let markId):
            return "?markId=\(markId)"
        case .getByTypeAndMark(let typeId,let markId):
            return "?typeId=\(typeId)&markId=\(markId)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getAll:
            return nil
        case .get:
            return nil
        case .getFeatured:
            return nil
        case .getDiscounted:
            return nil
        case .getByType:
            return nil
        case .getByMark:
            return nil
        case .getByTypeAndMark:
            return nil
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
