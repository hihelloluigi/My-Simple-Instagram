//
//  String+XT.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 05/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation

extension String {
    func localized(withTableNamed tableName: String, bundle: Bundle = Bundle.main, comment: String = "") -> String {
        let translated = NSLocalizedString(self, tableName: tableName, comment: comment)
        return translated
    }
}

infix operator ~>
/**
 Returns the localized message for `localizationKey` in `tableName`;
 this function searches the strings table in the main bundle.
 
 - parameter tableName: the .strings file name that includes the translation of `localizationKey`
 - parameter localizationKey: the key for which a localized string should exist in file `tableName`.strings
 - returns: the localization for `localizationKey` in `tableName`
 */
func ~>(tableName: String, localizationKey: String) -> String {
    return localizationKey.localized(withTableNamed: tableName)
}
