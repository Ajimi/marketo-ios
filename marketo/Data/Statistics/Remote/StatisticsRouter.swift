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
    
    case getStatisticsByMarkets(basket : [ProductInBasketCodable])
    case getStatisticsByPrices(basket : [ProductInBasketCodable])
    
    
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
        case .getStatisticsByMarkets:
            return nil
        case .getStatisticsByPrices:
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
        
        
        let encoder = JSONParameterEncoder(encoder: JSONEncoder())
        
        // Parameters
        switch self {
        case .getStatisticsByMarkets(let productBasket):
            return try encoder.encode(productBasket, into: urlRequest)
        case .getStatisticsByPrices(let productBasket):
            return try encoder.encode(productBasket, into: urlRequest)
        }
    }
    
}
