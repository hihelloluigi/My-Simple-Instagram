//
//  API+Comment.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 04/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

extension API {
    class CommentClass {
        //Doesn't work
        class func getCommentsWith(mediaId id: String, _ completionHandler: SuccessHandler?) {
            API.provider().request(.getCommentsWith(mediaId: id)) { (result) in
                switch result {
                case let .success(response):
                    let json = JSON(data: response.data)
                    guard json["meta"]["code"] == 200 else {
                        completionHandler?(false)
                        return
                    }
                    let result = ResponseParser.Comments.parseAndStoreComment(json: json, imageId: id)
                    completionHandler?(result)
                case .failure(_):
                    completionHandler?(false)
                }
            }
        }
    }
}
