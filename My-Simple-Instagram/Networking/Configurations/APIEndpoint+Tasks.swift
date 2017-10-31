//
//  APIEndpoint+Tasks.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya

extension APIEndpoint {
    var task: Task {
        switch self {
        case .getMyInfo():
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getUserInfo(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getMyRecentMedia(let maxId, let minId, let number):
            return .requestParameters(parameters: ["access_token": accessToken, "max_id": maxId, "min_id": minId, "count": number], encoding: parameterEncoding)
        case .getUserRecentMedia(let maxId, let minId, let number):
            return .requestParameters(parameters: ["access_token": accessToken, "max_id": maxId, "min_id": minId, "count": number], encoding: parameterEncoding)
        case .getMyLike(let maxId, let number):
            return .requestParameters(parameters: ["access_token": accessToken, "max_id": maxId, "count": number], encoding: parameterEncoding)
        case .searchUser(let query, let number):
            return .requestParameters(parameters: ["access_token": accessToken, "q": query, "count": number], encoding: parameterEncoding)
        }
    }
    
    var accessToken: String {
        guard let at = Config.token() else {
            return ""
        }
        return at
    }
}
