//
//  BackendAPI.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import Foundation
import Moya

enum BackendApi {
    case getRate
    case getNews
}

extension BackendApi: TargetType {
    var baseURL: URL {
        switch self {
        case .getRate:
            return URL(string: "https://api.binance.com")!
        case .getNews:
            return URL(string: "https://min-api.cryptocompare.com/data/v2")!

        }
    }
    
    var path: String {
        switch self {
        case .getRate:
            return "/api/v3/ticker/price"
        case .getNews:
            return "/news/"

        }
    }
    var method: Moya.Method {
        switch self {
        case .getRate:
            return .get
        case .getNews:
            return .get
        }
    }
    
    var task: Moya.Task {
        guard let params else { return .requestPlain }
        
        return .requestParameters(parameters: params, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var params: [String: Any]? {
        var params = [String: Any] ()
        switch self {
        case .getRate:
                return nil
        case .getNews:
            params["api_key"] = "4ab84581cc7e2644b53e7064a1a4dbc8ec38baf042fc04651626eba3dd2839ef"
        }
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getRate, .getNews:
            return URLEncoding.queryString
//        case .getRate:
//            return JSONEncoding.prettyPrinted
       
        }
    }
}
