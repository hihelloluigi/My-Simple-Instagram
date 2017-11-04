//
//  Image.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 31/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import RealmSwift

class Image: Object {
    
    // MARK: - Properties
    @objc dynamic var imageId = ""
    @objc dynamic var userId = ""
    @objc dynamic var instaLink: String = ""
    @objc dynamic var creationTime: Date?
    @objc dynamic var commentsNumber: Int = 0
    @objc dynamic var likesNumber: Int = 0
    @objc dynamic var userHasLike: Bool = false
    @objc dynamic var attribution: String?
    @objc dynamic var highResolution: String = ""
    @objc dynamic var standardResolution: String = ""
    @objc dynamic var thumbnailResolution: String = ""
    @objc dynamic var locationName: String = ""
    @objc dynamic var coordinate: String = ""

    var tags = List<String>()
    var filters = List<String>()
    var fileTpe: FileType = .image

    override static func primaryKey() -> String? {
        return "imageId"
    }
    
    // MARK: - Constructors
    convenience init(imageId: String,
                     userId: String,
                     instaLink: String,
                     creationTime: Date?,
                     commentsNumber cn: Int,
                     likesNumber ln: Int,
                     userHasLike: Bool,
                     attribution: String?,
                     highResolution: String,
                     standardResolution: String,
                     thumbnailResolution: String,
                     locationName: String?) {
        self.init()
        
        self.imageId = imageId
        self.userId = userId
        self.instaLink = instaLink
        self.creationTime = creationTime
        self.commentsNumber = cn
        self.likesNumber = ln
        self.userHasLike = userHasLike
        self.attribution = attribution ?? ""
        self.highResolution = highResolution
        self.standardResolution = standardResolution
        self.thumbnailResolution = thumbnailResolution
        self.locationName = locationName ?? ""
    }
    
    class func getImage(withId id: String) -> Image? {
        let predicate = NSPredicate(format: "imageId == %@", id)
        return Database.shared.query(entitiesOfType: Image.self, where: predicate)?.first
    }
    
    class func getAllImages(withUserID id: String) -> [Image] {
        let predicate = NSPredicate(format: "userId == %@", id)
        return Object.all(where: predicate)
    }
}
