//
//  UserRouter.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire


protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}


enum UserRouter: APIConfiguration {
    
    case createUser(user: User)
    case loginUser(email:String, password:String)
    case readUser(id: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .loginUser:
            return .post
        case .readUser:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .createUser:
            return "/users"
        case .loginUser:
            return "/authentication"
        case .readUser(let id):
            return "/users/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .loginUser(let email, let password):
            return ["strategy": "local",
                    APIUserParameterKey.email: email,
                    APIUserParameterKey.password: password]
        case .readUser:
            return nil
        case .createUser(let user):
            return  [APIUserParameterKey.email : user.email , APIUserParameterKey.password : user.password ,
                     APIUserParameterKey.username: user.username, APIUserParameterKey.fullname: user.fullName]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
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
