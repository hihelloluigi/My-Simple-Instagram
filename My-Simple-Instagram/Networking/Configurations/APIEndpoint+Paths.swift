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
        case .getMyInfo():
            return ("users/self")
        case .getUserInfo(_):
            return ("/user/signup")
        case .getMyRecentMedia(_, _, _):
            return ("/user/signup")
        case .getUserRecentMedia(_, _, _):
            return ("/user/signup")
        case .getMyLike(_, _):
            return ("/user/signup")
        case .searchUser(_, _):
            return ("/user/signup")
        }
    }
}
