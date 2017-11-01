//
//  UIImageView+XT.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 01/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    /**
     Created a rounded image.
     */
    func isCircle() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
