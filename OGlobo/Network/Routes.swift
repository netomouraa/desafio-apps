//
//  Routes.swift
//  OGlobo
//
//  Created by Neto Moura on 27/09/17.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import Foundation
import Alamofire

enum RouterOGlobo: URLRequestConvertible {
    
    static let baseURLString = "https://raw.githubusercontent.com"
    
    case desafioApps
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
            
        case .desafioApps:
            return "/Infoglobo/desafio-apps/master/capa.json"
        default:
            return ""
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RouterOGlobo.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}
