//
//  MasterCodable.swift
//  Jett
//
//  Created by Felipe Arturo. Perez Camargo on 11/14/19.
//  Copyright (c) 2019 Felipe Arturo. Perez Camargo. All rights reserved.
//

import Foundation
/// Protocol that contains default encode and decode.
internal protocol MasterCodable {
    ///Method to decode each kind of data in custom way, default method already provided
    func decode(data: Data) -> AnyObject?
    ///Optional method to implement if something custom is needed, extension already has a default implementation
    func encode<T: Encodable>(object: T, type: EncodeType) -> Data?
    ///Optional method to encode objects in URL format, extension already has a default implementation
    func encodeForURL<T: Encodable>(object: T) -> Data?
    ///Optional method to encode for JSON, extension already has a default implementation
    func encodeForJson<T: Encodable>(object: T) -> Data?
}

extension MasterCodable {
    ///Default implementation of Encodable for APIs in JSON and URLencoded
    func encode<T: Encodable>(object: T, type: EncodeType) -> Data?  {
        switch type {
        case .jsonEncode:
            return self.encodeForJson(object: object)
        case .fromURLEncoded:
            return self.encodeForURL(object: object)
        }
    }
    ///Default implementation of Encodable for APIs in JSON
    func encodeForJson<T: Encodable>(object: T) -> Data? {
        do {
            let encoded = try JSONEncoder().encode(object)
            return encoded
        } catch {
            return nil
        }
    }
    ///Default implementation of Encodable for APIs expecting url encoded
    func encodeForURL<T: Encodable>(object: T) -> Data? {
        let mirrow = Mirror(reflecting: object).children
        var encoded = ""
        for (index, (name,value)) in mirrow.enumerated() {
           guard let _name = name else { return nil }
           encoded = "\(encoded)\(_name)=\(value)"
           encoded = index == (mirrow.count - 1) ? "\(encoded)" : "\(encoded)&"
        }
        
        encoded = encoded.addingPercentEncodingForQueryParameter() ?? encoded

        guard let data = encoded.data(using: .utf8) else { return nil }

        return Data(data)
    }
    
    ///Default implementation of Decodable for APIs in JSON
    func decode<T: Decodable>(data: Data, type: T.Type) -> AnyObject? {
        do {
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded as AnyObject
        } catch {
            return nil
        }
    }
}
