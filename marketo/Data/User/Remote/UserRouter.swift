//
//  UserRouter.swift
//  marketo
//
//  Created by selim ajimi on 11/10/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire


enum UserRouter: APIConfiguration {
    
    case createUser(user: User)
    case loginUser(username:String, password:String)
    case readUser(id: Int, token: String)
    case modifyPassword(id: Int, user: PasswordChangeRequest, token: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .createUser:
            return .post
        case .loginUser:
            return .post
        case .readUser:
            return .get
        case .modifyPassword:
            return .patch
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .createUser:
            return "/users"
        case .loginUser:
            return "/authentication"
        case .readUser(let id, _):
            return "/users/\(id)"
        case .modifyPassword(let id, _,_):
            return "/users/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .loginUser(let username, let password):
            return ["strategy": "local",
                    APIUserParameterKey.username: username,
                    APIUserParameterKey.password: password]
        case .readUser:
            return nil
        case .createUser(let user):
            return  [APIUserParameterKey.email : user.email as! String ,
                     APIUserParameterKey.password : user.password as! String,
                     APIUserParameterKey.fullname : user.fullName as! String,
                     APIUserParameterKey.username: user.username as! String,
                     APIUserParameterKey.type: user.type as! String]
        case .modifyPassword(let id, let user, let token):
            return [APIUserParameterKey.password : user.password]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        switch self {
        case .modifyPassword(_,_, let token):
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization" )
        case .readUser(_,let token):
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization" )
        default:
            return urlRequest
        }
        
        
        return urlRequest
    }
}
