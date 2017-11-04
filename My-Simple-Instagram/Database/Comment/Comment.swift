//
//  File.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 04/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import RealmSwift

class Comment: Object {

    // MARK: - Properties
    @objc dynamic var commentId = ""
    @objc dynamic var imageId = ""
    @objc dynamic var commentText = ""
    @objc dynamic var creationTime = ""
    @objc dynamic var userId = ""
    @objc dynamic var username = ""
    @objc dynamic var profilePicture = ""
    @objc dynamic var fullName = ""
    
    override static func primaryKey() -> String? {
        return "commentId"
    }
    
    // MARK: - Constructors
    convenience init(commentId: String,
                     imageId: String,
                     commentText: String,
                     creationTime: String,
                     userId: String,
                     username: String,
                     profilePicture: String,
                     fullName: String) {
        self.init()
        
        self.commentId = commentId
        self.imageId = imageId
        self.commentText = commentText
        self.creationTime = creationTime
        self.userId = userId
        self.username = username
        self.profilePicture = profilePicture
        self.fullName = fullName
    }
    
    class func getComment(withId id: String) -> Comment? {
        let predicate = NSPredicate(format: "commentId == %@", id)
        return Database.shared.query(entitiesOfType: Comment.self, where: predicate)?.first
    }
    
    class func getAllComments(withImageID id: String) -> [Comment] {
        let predicate = NSPredicate(format: "imageId == %@", id)
        return Object.all(where: predicate)
    }
}
