//
//  API+User.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 30/10/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import Moya

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
                    print(response.data)
                    completionHandler?(true)
                case .failure(_):
                    completionHandler?(false)
                }
            }
        }
    }
}
