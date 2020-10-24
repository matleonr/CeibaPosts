//
//  UrlServicesHelper.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation

enum UrlServicesHelper: CustomStringConvertible {
    case getPosts
    case getUsers

    var description: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getUsers:
            return "users"
        }
    }
}

