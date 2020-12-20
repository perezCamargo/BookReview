//
//  NetworkRequester.swift
//  Jett
//
//  Created by Felipe Arturo. Perez Camargo on 11/14/19.
//  Copyright (c) 2019 Felipe Arturo. Perez Camargo. All rights reserved.
//

import Foundation

/// Protocol that contains what a service needs to conform to execute a call
internal protocol NetworkRequester: MasterCodable {
    ///Success closure to send data to caller
    typealias success = (_ response: Any?, _ statusCode: Int) -> Void
    ///Failure closure to send [NetworkError](x-source-tag://NetworkError) to caller
    typealias failure = (_ model: NetworkError?) -> Void
    ///recipe to build the Request
    var recipe: RequestRecipe? { get }
}

extension NetworkRequester {
    ///property to build the URLRequest based on the recipe
    private var request: URLRequest? {
        guard let recipe = self.recipe else {
            return nil
        }
        
        var request = URLRequest(url: recipe.url)

        request.httpMethod = recipe.method.rawValue

        request.allHTTPHeaderFields = recipe.headers
		
		if let police = recipe.police {
            request.cachePolicy = police
        }
		
		if let body = recipe.body {
            request.httpBody = body
        }
        
        return request
    }
    
    ///Function to invoke the service call with the local request property.
    /// - Returns: URLSessionDataTask
    @discardableResult
    func invoke( onFailure failure: failure? = nil,
                onSuccess success: @escaping success) -> URLSessionDataTask? {
        
        guard let request = self.request else {
            failure?(.requestError)
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if  nil != error  {
                failure?(.requestError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(.genericError)
                return
            }
            
            // Errors other than 200 codes should be handled here if make sense for your app
            if 500 > httpResponse.statusCode && 399 < httpResponse.statusCode {
                // verify that data exist and it is an error response with an object in the json TODO: decode an handle specific error
                guard let _ = data else {
                    failure?(.genericError)
                    return
                }
                
                failure?(.genericError)
                return
            }
            
            guard let _data = data else {
                failure?(.genericError)
                return
            }
            
            guard let decoded = self.decode(data: _data) else {
                failure?(.decodeError)
                return
            }
            
            success(decoded, httpResponse.statusCode)
        }
        
        task.resume()
        return task
    }
}
