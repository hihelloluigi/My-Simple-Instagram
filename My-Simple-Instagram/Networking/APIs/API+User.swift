//
//  API+User.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

extension API {
    
    class UserClass {
        /**
         Downloads all events and surveys to display in agenda which will take place in the future.
             - parameter completionHandler: the optional completionHandler invoked whenever the request succeedes or fails
         */
        class func getMyProfile(_ completionHandler: SuccessHandler?) {
            API.provider().request(.getMyInfo()) { (result) in
                switch result {
                case let .success(response):
                    let json = JSON(data: response.data)
                    //TO DO - Improve
                    guard json["meta"]["code"] == 200, let myID = json["data"]["id"].string else {
                        completionHandler?(false)
                        return
                    }
                    Config.store(id: myID)
                    let result = ResponseParser.Users.parseAndStoreUserProfile(json: json)
                    completionHandler?(result)
                case .failure(_):
                    completionHandler?(false)
                }
            }
        }
        
        class func getUserProfile(userId id: Int, _ completionHandler: SuccessHandler?) {
            API.provider().request(.getUserInfo(userId: String(id))) { (result) in
                switch result {
                case let .success(response):
                    let json = JSON(data: response.data)
                    guard json["meta"]["code"] == 200 else {
                        completionHandler?(false)
                        return
                    }
                    
                    print(json)
                    completionHandler?(true)
                case .failure(_):
                    completionHandler?(false)
                }
            }
        }
        
        class func getMyMedia(maxId: String, minId: String, count: String, _ completionHandler: SuccessHandler?) {
            API.provider().request(.getMyRecentMedia(maxId: maxId, minId: minId, number: count)) { (result) in
                switch result {
                case let .success(response):
                    let json = JSON(data: response.data)
                    guard json["meta"]["code"] == 200 else {
                        completionHandler?(false)
                        return
                    }
//                    print(json)
                    let result = ResponseParser.Users.parseAndStoreGallery(json: json)
                    completionHandler?(result)
                case .failure(_):
                    completionHandler?(false)
                }
            }
        }

        
        
    }
}
