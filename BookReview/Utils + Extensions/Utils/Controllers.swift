//
//  Controllers.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 19/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

enum Controllers {
    case reviews
    case reviewDetails
    case users
    case userReviews
    
    private var storyboard: Storyboards {
        switch self {
        case .reviews:
            return .lists
        case .users:
            return .lists
        case .reviewDetails:
            return .main
        default:
            return .main
        }
    }
    
    func instance<T: UIViewController>() -> T {
        guard let vc = storyboard.file.instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError(instanceError)
        }
        return vc
    }
}

private extension Controllers {
    private var instanceError: String {
        return "Can not instantiate: \(self) from: \(self.storyboard.rawValue)"
    }
}
