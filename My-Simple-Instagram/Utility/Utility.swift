//
//  Utility.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    static func link(url: String?) {
        if let _url = url {
            if (!_url.hasPrefix("http://") && !_url.hasPrefix("https://")) {
                self.open(url: "http://\(_url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))")
            }else {
                self.open(url: _url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            }
        }
    }
    
    static func open(url: String?, errorHandler : (() -> Void)? = nil) {
        if let url = url, let _url = URL(string: url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(_url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(_url)
            }
        } else {
            if let errorHandler = errorHandler {
                errorHandler()
            }
        }
    }
}

