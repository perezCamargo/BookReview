//
//  Images.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

enum Images: String {
    case placeHolder = "place_holder"
    case firstTabBarIcon = "first"
    case secondTabBarIcon = "second"
    case empty = "empty"
    case loader = "loader"
    
    var image: UIImage {
        switch self {
        case .empty:
            return UIImage()
        default:
             return UIImage(named: self.rawValue) ?? self.placeHolderImage
        }
    }
    
    var templateImage: UIImage { return self.image.withRenderingMode(.alwaysTemplate) }
    
    var placeHolderImage: UIImage { return UIImage(named: Images.placeHolder.rawValue)! }
}
