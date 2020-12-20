//
//  Localizable.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

protocol Localizable {
    func localized(bundle: Bundle, tableName: String) -> String
    func localized(with key: String, bundle: Bundle, tableName: String) -> String
}

// MARK: - Strings localization
extension Localizable where Self == String {
    /// Method to access to Localized strings in easy way
    ///
    /// - Parameters:
    ///   - bundle: Optional parameter to find the file(table) to use
    ///   - tableName: If different localized.string file is required
    /// - Returns: Localized string from the specific string passed
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }

    /// Method to access to localized string in a swifty way
    ///
    /// - Parameters:
    ///   - key: string to localize
    ///   - bundle: Optional parameter to find the file(table) to use
    ///   - tableName: If different localized.string file is required
    /// - Returns: Localized string from the specific string passed
    func localized(with key: String, bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return key.localized(bundle: bundle, tableName: tableName)
    }
}

///Extension to allow all Strings and subclasses be localized
/// - Tag: Localizable
extension String: Localizable { }
