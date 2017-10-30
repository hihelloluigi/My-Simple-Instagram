//
//  API.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Alamofire
import Moya

class API {
    class func provider() -> MoyaProvider<APIEndpoint> {
        let closure = { (target: APIEndpoint) -> Endpoint<APIEndpoint> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString

            return Endpoint(url: url,
                            sampleResponseClosure: { .networkResponse(200, Data()) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let networkActivityPlugin = NetworkActivityPlugin { (type, target) in
            switch type {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
        return MoyaProvider<APIEndpoint>(
            endpointClosure: closure,
            manager: Alamofire.SessionManager(configuration: configuration),
            plugins: [networkActivityPlugin]
        )
    }
}
