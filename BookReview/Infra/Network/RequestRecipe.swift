//
//  RequestRecipe.swift
//  Jett
//
//  Created by Felipe Arturo. Perez Camargo on 11/14/19.
//  Copyright (c) 2019 Felipe Arturo. Perez Camargo. All rights reserved.
//

import Foundation

/// Struct that contains all what you would need to build an URLRequest.
///
/// **Properties**:
///   - url: URL of the call
///   - method: HTTP method -> **GET** by default
///   - body: body of the request -> **nil** by default
///   - headers: headers of the request -> **accept : applicationJSON** by default
///	  - police: CachePolicy -> *cachePolicy : useProtocolCachePolicy* - non bye default
internal struct RequestRecipe {
    var url: URL
    var method: HTTPMethod
    var body: Data?
    var headers: [String:String]
	var police: URLRequest.CachePolicy?
    

    ///Custom init method where the only needed parameter is the URL, all the rest are handled by default values if not specified.
    ///
    /// - Parameters:
    ///   - url: URL of the call
    ///   - method: HTTP method -> *GET* by defualt
    ///   - body: body of request -> *nil* by default
    ///   - headers: headers -> *accept : applicationJSON* by default
	///   - police: CachePolicy -> *cachePolicy : useProtocolCachePolicy* - non bye default
	init(url: URL, method: HTTPMethod = HTTPMethod.GET, body: Data? = nil, headers: [String:String] = [Headers.Keys.contentType: Headers.Values.applicationJSON], police: URLRequest.CachePolicy? = .none) {
        self.url = url
        self.method = method
        self.body = body
        self.headers = headers
		self.police = police
    }
}
