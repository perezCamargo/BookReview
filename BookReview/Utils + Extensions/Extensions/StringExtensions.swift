//
//  StringExtensions.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
