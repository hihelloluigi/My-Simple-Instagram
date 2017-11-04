//
//  ReponserParser+Comment.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 04/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import SwiftyJSON

extension ResponseParser {
    class Comments {
        class func parseAndStoreComment(json: JSON, imageId: String) -> Bool {
            let data = json["data"]
        
            guard
                let commentId = data["id"].string,
                let commentText = data["text"].string,
                let creationTime = data["created_time"].string,
                let userId = data["from"]["id"].string,
                let username = data["from"]["username"].string,
                let profilePicture = data["from"]["profile_picture"].string,
                let fullName = data["from"]["full_name"].string
            else {
                print("User parse error")
                return false
            }
            
            let comment = Comment(commentId: commentId,
                                  imageId: imageId,
                                  commentText: commentText,
                                  creationTime: creationTime,
                                  userId: userId,
                                  username: username,
                                  profilePicture: profilePicture,
                                  fullName: fullName)
            
            return comment.store(update: true)
        }
    }
}
