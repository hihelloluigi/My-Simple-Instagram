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
    case getUserRecentMedia(maxId: String, minId: String, number: String)
    case getMyLike(maxId: String, number: String)
    case searchUser(query: String, number: String)
}
