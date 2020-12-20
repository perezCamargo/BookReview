//
//  ListModel.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

// Easier to handle ui and reuse code
enum ListModel {
    case users([UserModel])
    case reviews([PostModel])
}
