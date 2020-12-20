//
//  Rotable.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

/// Basic protocol to rotate any kind of UIView if the class conforms this protocol.
/// *Already implemented this protocol in a UIView extension in this project* so all UIView subclasses are rotable.
/// [UIView Extension](x-source-tag://RotableView)
protocol Rotable: class {
    /// The Transform of the current UIView. Using the already written var in UIView swift class.
    var transform: CGAffineTransform {get set}
    var rotation: (radians: CGFloat, degrees: CGFloat) { get }
    func rotate(degrees: CGFloat, animated: Bool, duration: Double)
    func rotate(radians: CGFloat, animated: Bool, duration: Double)
}

extension Rotable {
    /// Method to rotate the UIView where this method is called using degrees to measure the rotation.
    ///
    /// - Parameters:
    ///   - degrees: the amount of degrees to rotate the UIView
    ///   - animated: if animated is set `true`, the view will be rotated with animation. Default `false`
    ///   - duration: this is the duratio of the rotation in seconds. Default `0.5`. Working only if the `animation` flag is set to true
    func rotate(degrees: CGFloat, animated: Bool = false, duration: Double = 0.5) {
        self.rotate(radians: self.degreesToRadians(value: degrees), animated: animated, duration: duration)
    }

    /// Method to rotate the UIView where this method is called using radians to measure the rotation.
    ///
    /// - Parameters:
    ///   - radians: the amount of radiands to rotate the UIView
    ///   - animated: if animated is set `true`, the view will be rotated with animation. Default `false`
    ///   - duration: this is the duratio of the rotation in seconds. Default `0.5`. Working only if the `animation` flag is set to true
    func rotate(radians: CGFloat, animated: Bool = false, duration: Double = 0.5 ) {
        if animated {
            UIView.animate(withDuration: duration) { [weak self] in
                self?.transform = CGAffineTransform(rotationAngle: radians)
            }
        } else {
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }

    /// The rotation in degrees or radians of the View from x:0,y:0 starting point.
    var rotation: (radians: CGFloat, degrees: CGFloat) {
        let radians = CGFloat(atan2f(Float(transform.b), Float(transform.a)))
        return (radians, radiansToDegrees(value: radians))
    }

    func degreesToRadians(value: CGFloat) -> CGFloat {
        return CGFloat(Double.pi) * value / 180.0
    }

    func radiansToDegrees(value: CGFloat) -> CGFloat {
        return value * 180.0 / CGFloat(Double.pi)
    }
}

///Extension to allow all UIViews subclasses to rotate in an easy way
/// - Tag: RotableView
extension UIView: Rotable {}
