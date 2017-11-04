//
//  APIEndpoint+Paths.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation

extension APIEndpoint {
    var path: String {
        switch self {
        
        //MARK:- Users
        case .getMyInfo():
            return ("users/self")
        case .getUserInfo(let userId):
            return ("/users/\(userId)")
        case .getMyRecentMedia(_, _, _):
            return ("/users/self/media/recent")
        case .getUserRecentMedia(let userId, _, _):
            return ("/users/\(userId)/media/recent")
        case .getMyLike(_, _):
            return ("/users/self/media/liked")
        case .searchUser(_, _):
            return ("/users/search")
           
        // MARK:- Relationships
        case .getFollows():
            return ("users/self/follows")
        case .getFollowedBy():
            return ("users/self/followed-by")
        case .getRequestedBy():
            return ("users/self/requested-by")
        case .getRelationshipWith(let userId):
            return ("/users/\(userId)/relationship")
        case .modifyRelationshipWith(let userId):
            return ("/users/\(userId)/relationship")
            
        // MARK:- Media
        case .getMediaWithId(let mediaId):
            return ("/media/\(mediaId)")
        case .getMediaWithShortCode(let shortCodeId):
            return ("/media/shortcode/\(shortCodeId)")
        case .getMediaWithArea(_, _, _):
            return ("/media/search")
            
        //MARK:- Comments
        case .getCommentsWith(let mediaId):
            return ("/media/\(mediaId)/comments")
        }
    }
}
