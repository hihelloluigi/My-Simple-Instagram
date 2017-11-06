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
    
    //Keys
    static let kAUTHURL: String = "INSTAGRAM_AUTHURL"
    static let kCLIENTID = "INSTAGRAM_CLIENT_ID"
    static let kCLIENTSERCRET = "INSTAGRAM_CLIENTSERCRET"
    static let kREDIRECT = "INSTAGRAM_REDIRECT_URI"
    static let kACCESSTOKEN = "INSTAGRAM_ACCESS_TOKEN"
    static let kSCOPE = "INSTAGRAM_SCOPE"

    class var dict: NSDictionary {
        get {
            guard let p = Bundle.main.path(forResource: "InstaConfig", ofType: "plist"),
                let d = NSDictionary(contentsOfFile: p) else {
                return [:]
            }
            return d
        }
    }
    
    static let INSTAGRAM_AUTHURL = dict[kAUTHURL] as! String
    static let INSTAGRAM_CLIENT_ID = dict[kCLIENTID] as! String
    static let INSTAGRAM_CLIENTSERCRET = dict[kCLIENTSERCRET] as! String
    static let INSTAGRAM_REDIRECT_URI = dict[kREDIRECT] as! String
    static let INSTAGRAM_ACCESS_TOKEN = dict[kACCESSTOKEN] as! String
    static let INSTAGRAM_SCOPE = dict[kSCOPE] as! String/* add whatever scope you need https://www.instagram.com/developer/authorization/ */
}

