//
//  APIEndpoint+Methods.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya

extension APIEndpoint {
    var method: Moya.Method {
        switch self {
        case .getMyInfo(), .getUserInfo(_), .getMyRecentMedia(_, _, _), .getUserRecentMedia(_, _, _), .getMyLike(_, _), .searchUser(_, _),
             .getFollows(), .getFollowedBy(), .getRequestedBy(), .getRelationshipWith(_), .getMediaWithId(_), .getMediaWithShortCode(_), .getMediaWithArea(_, _, _), .getCommentsWith(_):
            return .get
        case .modifyRelationshipWith(_):
            return .post
        }
    }
}
