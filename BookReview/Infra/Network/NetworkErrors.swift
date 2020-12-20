//
//  NetworkErrors.swift
//  Jett
//
//  Created by Felipe Arturo. Perez Camargo on 11/14/19.
//  Copyright (c) 2019 Felipe Arturo. Perez Camargo. All rights reserved.
//

import Foundation

/// Predefined Errors for network flow, if a new error is needed just add here.
///
/// **Errors Available**:
/// - encodeError: Error | Encoding Model
/// - decodeError: Error | Decoding Response
/// - requestError: Error | Creating the URLRequest object from RequestRecipe
/// - responseDataError: Error | The Response Data is nil or in incorrect format
/// - httpCallError: Error | Error in the HTTP Call
///
/// **var debugDescription: String** Used to return the description of the error.
///  - Tag: NetworkError
internal enum NetworkError: String, Error, Decodable {
    case genericError = "Oops! Something went wrong 🤷‍♂️"
    case encodeError = "::: Error | Encoding Model :::"
    case decodeError = "::: Error | Decoding Response :::"
    case requestError = "::: Error | Creating the URLRequest object from RequestRecipe :::"
    case responseDataError = "::: Error | The Response Data is nil or in incorrect format :::"
    case httpCallError = "::: Error | Error in the HTTP Call :::"
    case none = "::: NoError | Used as initial value :::"
    
    var debugDescription: String {
        return self.rawValue
    }
    
    var title: String {
       return "Oops!"
    }
}
