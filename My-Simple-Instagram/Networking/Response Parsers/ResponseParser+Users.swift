//
//  ResponseParser+Users.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya
import RealmSwift
import SwiftyJSON

extension ResponseParser {
    class Users {
        
//        {
//            "data": {
//                "id": "1574083",
//                "username": "snoopdogg",
//                "full_name": "Snoop Dogg",
//                "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_1574083_75sq_1295469061.jpg",
//                "bio": "This is my bio",
//                "website": "http://snoopdogg.com",
//                "counts": {
//                "media": 1320,
//                "follows": 420,
//                "followed_by": 3410
//            }
//        }
        
        class func parseAndStoreUserProfile(json: JSON) -> Bool {
            let data = json["data"]
            
            guard
                let userID = data["id"].string,
                let username = data["username"].string,
                let fullName = data["full_name"].string,
                let profilePicture = data["profile_picture"].string,
                let bio = data["bio"].string,
                let website = data["website"].string,
                let media = data["counts"]["media"].int,
                let follows = data["counts"]["follows"].int,
                let follows_by = data["counts"]["followed_by"].int
            else {
                print("User parse error")
                return false
            }
            
            let user = User(userID: userID,
                            username: username,
                            fullName: fullName,
                            profilePicture: profilePicture,
                            bio: bio,
                            website: website,
                            media: media,
                            follows: follows,
                            followedBy: follows_by)
            
            return user.store(update: true)
        }
        
        class func parseAndStoreGallery(json: JSON) -> Bool {
            guard let images = json["data"].array else {
                print("Images is not an array")
                return false
            }
            
            for image in images {
                guard
                    let imageId = image["id"].string,
                    let userId = image["user"]["id"].string,
                    let instaLink = image["link"].string,
                    let creationTimeString = image["created_time"].string, let creationTimeInt = Int(creationTimeString),
                    let commentsNumber = image["comments"]["count"].int,
                    let likesNumber = image["likes"]["count"].int,
                    let userHasLike = image["user_has_liked"].bool,
                    let highResolution = image["images"]["low_resolution"]["url"].string,
                    let standardResolution = image["images"]["standard_resolution"]["url"].string,
                    let thumbnailResolution = image["images"]["thumbnail"]["url"].string
                else {
                    print("Image parse error")
                    return false
                }
                
                let imageEntity = Image(imageId: imageId,
                                  userId: userId,
                                  instaLink: instaLink,
                                  creationTime: Date(),
                                  commentNumber: commentsNumber,
                                  likesNumber: likesNumber,
                                  userHasLike: userHasLike,
                                  attribution: image["attribution"].string,
                                  highResolution: highResolution,
                                  standardResolution: standardResolution,
                                  thumbnailResolution: thumbnailResolution)
                
                let _ = imageEntity.store(update: true)
            }
            
            return true
        }
    }
}
