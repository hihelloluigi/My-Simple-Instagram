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
            return .requestPlain
        case .getUserInfo(let userId):
            return .requestPlain
        case .getMyRecentMedia(let maxId, let minId, let number):
            return .requestPlain
        case .getUserRecentMedia(let maxId, let minId, let number):
            return .requestPlain
        case .getMyLike(let maxId, let number):
            return .requestPlain
        case .searchUser(let query, let number):
            return .requestPlain
        default:
            return .requestPlain
        }
    }
}
