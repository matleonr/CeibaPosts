//
//  User.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation

// MARK: - User
class User: Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.username == rhs.username && lhs.email == rhs.email && lhs.address == rhs.address && lhs.phone == rhs.phone && lhs.website == rhs.website && lhs.company == rhs.company
    }
    
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
    
    init() {
    }
    
    init(id: Int?, name: String?, username: String?, email: String?, address: Address?,phone: String?, website: String?,company: Company?) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}

// MARK: - Address
struct Address: Codable, Equatable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable, Equatable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable, Equatable {
    let name, catchPhrase, bs: String
}

