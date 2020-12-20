//
//  PostsEndpoints.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

enum PostsEndpoints: NetworkRequester {
    /// **Returns** [PostModel]
    case getPosts
    /// **Returns** PostModel of given _id_
    case getPost(id: Int)
    /// **Returns** [PostModel] for the specific user
    case getUserPosts(userId: Int)
    
    private var url: URL? {
        let baseURL = Environment.baseURL.value(defaultValue: "")
        
        switch self {
        case .getPosts:
            return "\(baseURL)/posts".toURL()
        case .getPost(id: let id):
            return "\(baseURL)/posts/\(id)".toURL()
        case .getUserPosts(userId: let id):
            return  "\(baseURL)/users/\(id)/posts".toURL()
        }
    }
    
    var recipe: RequestRecipe? {
        guard let url = self.url else { return nil }
        
        return RequestRecipe(url: url)
    }
    
    func decode(data: Data) -> AnyObject? {
        switch self {
        case .getPosts, .getUserPosts:
            return decode(data: data, type: [PostModel].self)
        case .getPost:
            return decode(data: data, type: PostModel.self)
        }
    }
}
