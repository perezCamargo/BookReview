//
//  PostModel.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

struct PostModel: Decodable, Printable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
