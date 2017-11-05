//
//  AppConfig.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation

class AppConfig {
    
    // MARK: - Singleton instance
    static let sharedInstance = AppConfig()
    
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_CLIENT_ID = "2662b83c8a6d4b1a910c677cc638bc2d"
    static let INSTAGRAM_CLIENTSERCRET = "dab1cc77151446858ffad168ebd2981b"
    static let INSTAGRAM_REDIRECT_URI = "http://www.luigiaiello.org"
    static let INSTAGRAM_ACCESS_TOKEN = "access_token"
    static let INSTAGRAM_SCOPE = "follower_list+public_content" /* add whatever scope you need https://www.instagram.com/developer/authorization/ */
}

