//
//  StatisticsRouter.swift
//  marketo
//
//  Created by Moncef Guettat on 1/2/19.
//  Copyright © 2019 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

enum StatisticsRouter: APIConfiguration{
    
    case getStatisticsByMarkets(basket : ProductsInBasket)
    case getStatisticsByPrices(basket : ProductsInBasket)
    
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .getStatisticsByMarkets:
            return .post
        case .getStatisticsByPrices:
            return .post
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getStatisticsByMarkets:
            return "/markets"
        case .getStatisticsByPrices:
            return "/prices"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getStatisticsByMarkets(let basket):
            return nil
        case .getStatisticsByPrices(let basket):
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent("/stats\(path)"))
        
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
