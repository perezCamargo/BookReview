//
//  Storyboards.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 19/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case main = "Main"
    
    var file: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: bundle)
    }

    private var bundle: Bundle? {
        switch self {
        case .main:
            return nil
        }
    }
}
