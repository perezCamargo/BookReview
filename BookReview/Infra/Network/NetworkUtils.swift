//
//  NetworkUtils.swift
//  Jett
//
//  Created by Felipe Arturo. Perez Camargo on 11/14/19.
//  Copyright (c) 2019 Felipe Arturo. Perez Camargo. All rights reserved.
//

import UIKit

/// Common headers, Keys and Values, if something is needed just add here.
///
/// **Headers Keys**:
///  - accept
///  - contentType
///  - authorization
///
/// **Headers Values**:
/// - applicationJSON
/// - applicationXML
/// - applicationFromURLEncoded
/// - basic
/// - bearer
internal struct Headers {
    struct Keys {
        static let accept = "accept"
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
    }
    
    struct Values {
        static let applicationJSON = "application/json"
        static let applicationXML = "application/xml"
        static let applicationFromURLEncoded = "application/x-www-form-urlencoded"
        static let applicationProtobuf = "application/protobuf"
        static let basic = "Basic"
        static let bearer =  "Bearer "
    }
}

/// Basic HTTP methods, if a new method is needed just add here.
///
/// **Methods Available**:
///    - GET
///    - POST
///    - PUT
internal enum HTTPMethod: String {
    case POST
    case GET
    case PUT
}

/// Enum to work with encode types based on different scenarios to send data to REST API
enum EncodeType {
    case jsonEncode
    case fromURLEncoded
    
    var rawValue: String {
        switch self {
        case .jsonEncode:
            return "JSON"
        case .fromURLEncoded:
            return "x-www-form-urlencoded"
        }
    }
}
