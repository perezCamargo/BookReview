//
//  Printable.swift
//  Jett
//
//  Created by Felipe Arturo. Perez Camargo on 10/23/18.
//  Copyright © 2018 Felipe Arturo. Perez Camargo. All rights reserved.
//

import Foundation

/// Protocol to print all the properties and values of each model, work with almost any object that
/// implements this protocol.
/// You just need to add this protocol to your declaration, and in your object instance call *prettyModel()* method, this will print
/// the object in console with a pretty structure.
protocol Printable {}

extension Printable {
    /// Public method to print the respective object in a readable format.
    @available(swift 4.0.2)
    @available(*, deprecated, message: "Printable protocol methods are not allowed for production, only debug environment as developer tool.")
    func prettyModel() {
        print(":::\(type(of: self)) Description:::\n")
        let description = self.detailedDescription()
        print(description)
    }

    /// Private method that creates the string with all the information in a readable format.
    ///
    /// - Parameters:
    ///   - prefix: Int value to calculate the indentation use **prefixString(_:Int)** method -> **0** by default
    ///   - label: String to attach the label for complex objects that conforms Printable -> **""** by default
    /// - Returns: String with readable format of all the properties
    private func detailedDescription(_ prefix: Int = 0, _ label: String = "") -> String {
        // TODO: Refactor this code to avoid duplicated code
        let m = Mirror(reflecting: self).children
        var s = ""
        if self is [Any] {
            if let a = self as? [Printable] {
                for e in a {
                    let _s = e.detailedDescription(prefix+1, "")
                    s += "\(_s)"
                }
                return "\(self.prefixString(prefix))\(label)<\(type(of: self))> = {\n\(s)\n\(self.prefixString(prefix))}\n"
            } else {
                if let a = self as? [Any] {
                    for (index, e) in a.enumerated() {
                        s += "\(self.prefixString(prefix+1))\(index): \(type(of: e)) = \(e)\n"
                    }
                }
            }
        }
        for (n, v) in m {
            guard let _n = n else { continue }

            if v is [Any] {
                if let a = v as? [Printable] {
                    let _s = a.detailedDescription(prefix+1, "\(_n)")
                    s += "\(_s)"
                } else {
                    if let a = v as? [Any] {
                        var _s = "\(self.prefixString(prefix+1))\(_n)<\(type(of: v))> = {\n"
                        for (index, e) in a.enumerated() {
                            _s += "\(self.prefixString(prefix+2))\(index): \(type(of: e)) = \(e)\n"
                        }
                        s += _s + "\(self.prefixString(prefix+1))}\n"
                    }
                }
            } else {
                if let _v = v as AnyObject as? Printable {
                    let _s = _v.detailedDescription(prefix+1, "\(_n)")
                    s += "\(_s)"
                } else {
                    s += "\(self.prefixString(prefix+1))\(_n): \(type(of: v)) = \(v)\n"
                }
            }
        }
        if s == "" {
            s = "\(self.prefixString(prefix+1))\(self)"
        }
        return "\(self.prefixString(prefix))\(label)<\(type(of: self))> = {\n\(s)\n\(self.prefixString(prefix))}\n"
    }

    /// Private method that generates the indentantion based on the prefix value.
    ///
    /// - Parameters:
    ///   - prefix: Int value to calculate the indentation and returns the string on that ways
    /// - Returns: String that is the correct indentation
    private func prefixString(_ prefix: Int) -> String {
        var pre = ""
        for _ in 0...prefix {
            pre += "\t"
        }

        return pre
    }
}

// MARK: - Adding the Printable protocol to Array to make them printable.
extension Array: Printable {}
