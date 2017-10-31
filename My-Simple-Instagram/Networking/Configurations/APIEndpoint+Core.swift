//
//  APIEndpoint+Core.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya

extension APIEndpoint: TargetType {
    
    var headers: [String : String]? {
        return [
            "Content-Type": contentType,
            "X-Language": Locale.current.languageCode ?? Locale.current.identifier
        ]
    }
    
    var baseURL: URL {
        return getProperEndpoint(api: self)
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.queryString
        }
    }
    
    var contentType: String {
        return "application/json"
    }
    
    var sampleData: Data {
        return try! JSONSerialization.data(withJSONObject: [String: String](), options: .prettyPrinted)
    }
    
    private func getProperEndpoint(api: APIEndpoint) -> URL {
        return URL(string:"https://api.instagram.com/v1")!
        
        //"AppConfig.sharedInstance.apiBaseURL")!
    }
}
