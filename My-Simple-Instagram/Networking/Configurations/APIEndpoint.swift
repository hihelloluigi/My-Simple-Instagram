//
//  APIEndpoint.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation

/**
 Defines endpoints exposed by the remote APIs.
 */
enum APIEndpoint {
    
    // MARK:- Users
    case getMyInfo()
    case getUserInfo(userId: String)
    case getMyRecentMedia(maxId: String, minId: String, number: String)
    case getUserRecentMedia(withId: String, maxId: String, minId: String, number: String)
    case getMyLike(maxId: String, number: String)
    case searchUser(query: String, number: String)
    
    // MARK:- Relationships
    case getFollows()
    case getFollowedBy()
    case getRequestedBy()
    case getRelationshipWith(userId: String)
    case modifyRelationshipWith(userId: String)
    
    // MARK:- Media
    case getMediaWithId(id: String)
    case getMediaWithShortCode(shortCode: String)
    case getMediaWithArea(latitude: String, longitude: String, distance: String)
    
    // MARK:- Comments
    case getCommentsWith(mediaId: String)
}
