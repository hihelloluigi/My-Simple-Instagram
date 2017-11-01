//
//  User.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    // MARK: - Properties
    @objc dynamic var userID = ""
    @objc dynamic var username = ""
    @objc dynamic var fullName = ""
    @objc dynamic var profilePicture = ""
    @objc dynamic var bio = ""
    @objc dynamic var website = ""
    @objc dynamic var media = 0
    @objc dynamic var follows = 0
    @objc dynamic var followedBy = 0
    
    override static func primaryKey() -> String? {
        return "userID"
    }
    
    // MARK: - Constructors
    convenience init(userID: String,
                     username: String,
                     fullName: String,
                     profilePicture picture: String,
                     bio: String,
                     website: String,
                     media: Int,
                     follows: Int,
                     followedBy: Int) {
        
        self.init()
        self.userID = userID
        self.username = username
        self.fullName = fullName
        self.profilePicture = picture
        self.bio = bio
        self.website = website
        self.media = media
        self.follows = follows
        self.followedBy = followedBy
    }
    
    class func get(withID id: String) -> User? {
        return Database.shared.query(entitiesOfType: User.self, where: NSPredicate(format: "userID == %@", id))?.first
    }
    
    class func getMyProfile() -> User? {
        guard let id = Config.id() else {
            return nil
        }
        return Database.shared.query(entitiesOfType: User.self, where: NSPredicate(format: "userID == %@", id))?.first
    }
}

