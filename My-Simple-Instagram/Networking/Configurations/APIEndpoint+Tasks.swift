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
            
        //MARK:- Users
        case .getMyInfo():
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getUserInfo(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getMyRecentMedia(let maxId, let minId, let number):
            return .requestParameters(parameters: ["max_id": maxId, "min_id": minId, "count": number, "access_token": accessToken,], encoding: parameterEncoding)
        case .getUserRecentMedia(let maxId, let minId, let number):
            return .requestParameters(parameters: ["max_id": maxId, "min_id": minId, "count": number, "access_token": accessToken], encoding: parameterEncoding)
        case .getMyLike(let maxId, let number):
            return .requestParameters(parameters: ["max_id": maxId, "count": number, "access_token": accessToken], encoding: parameterEncoding)
        case .searchUser(let query, let number):
            return .requestParameters(parameters: ["q": query, "count": number, "access_token": accessToken], encoding: parameterEncoding)
            
        //MARK:- Relationships
        case .getFollows():
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getFollowedBy(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getRequestedBy():
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getRelationshipWith(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .modifyRelationshipWith(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        
        // MARK:- Media
        case .getMediaWithId(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getMediaWithShortCode(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        case .getMediaWithArea(let latitude, let longitude, let distance):
            return .requestParameters(parameters: ["lat": latitude, "lng": longitude, "distance": distance, "access_token": accessToken], encoding: parameterEncoding)
            
        // MARK:- Comments
        case .getCommentsWith(_):
            return .requestParameters(parameters: ["access_token": accessToken], encoding: parameterEncoding)
        }
    }
    
    var accessToken: String {
        guard let at = Config.token() else {
            return ""
        }
        return at
    }
}
