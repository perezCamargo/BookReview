//
//  Environment.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 19/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

public enum Environment: String {
    case baseURL = "base_url"
}

extension Environment {
    fileprivate var info: [String: Any] {
        if let dic = Bundle.main.infoDictionary {
            return dic
        } else {
            fatalError("File not found")
        }
    }
       
    func value<T>(defaultValue: T) -> T {
        return self.info[self.rawValue] as? T ?? defaultValue
    }
    
    func value<T>() -> T? {
        return info[self.rawValue] as? T
    }
}
