//
//  UserEndpoints.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

enum UserEndpoints: NetworkRequester {
    /// **Returns** [UserModel]
    case getUsers
    /// **Returns** UserModel of given id
    case getUser(id: Int)
    
    private var url: URL? {
        let baseURL = Environment.baseURL.value(defaultValue: "")
        
        switch self {
        case .getUsers:
            return "\(baseURL)/users".toURL()
        case .getUser(id: let id):
            return "\(baseURL)/users/\(id)".toURL()
        }
    }
    
    var recipe: RequestRecipe? {
        guard let url = self.url else { return nil }
        
        return RequestRecipe(url: url)
    }
    
    func decode(data: Data) -> AnyObject? {
        switch self {
        case .getUsers:
            return decode(data: data, type: [UserModel].self)
        case .getUser:
            return decode(data: data, type: UserModel.self)
        }
    }
}
