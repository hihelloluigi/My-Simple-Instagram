//
//  Config.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation

/**
 This class is used to access the local configuration of the app.
 */
class Config {
    
    // MARK: - Constants
    fileprivate static let kToken = "kToken"
    fileprivate static let kMyId = "kMyId"

    // MARK: - Token management
    /**
     Stores a user token in user defaults.
         - parameter token: the token that should be stored
     */
    class func store(token: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(token, forKey: kToken)
        
        let _ = defaults.synchronize()
    }

    /**
     Returns the user token currently stored in user defaults.
         - returns: the token currently stored in the user defaults or `nil` if no token can be found
     */
    class func token() -> String? {
        guard let token = UserDefaults.standard.value(forKey: kToken) as? String else {
            return nil
        }
        
        return token
    }
    
    /**
     Stores my id in user defaults.
         - parameter id: the token that should be stored
     */
    class func store(id: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(id, forKey: kMyId)
        
        let _ = defaults.synchronize()
    }
    
    /**
     Returns the user id currently stored in user defaults.
         - returns: the id currently stored in the user defaults or `nil` if no token can be found
     */
    class func id() -> String? {
        guard let token = UserDefaults.standard.value(forKey: kMyId) as? String else {
            return nil
        }
        
        return token
    }
}
