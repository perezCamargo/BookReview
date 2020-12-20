//
//  UserModel.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

struct UserModel: Decodable, Printable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressModel
    let phone: String
    let website: String
    let company: CompanyModel
}

struct AddressModel: Decodable, Printable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoModel
}

struct GeoModel: Decodable, Printable {
    let lat: String
    let lng: String
}

struct CompanyModel: Decodable, Printable {
    let name: String
    let catchPhrase: String
    let bs: String
}
