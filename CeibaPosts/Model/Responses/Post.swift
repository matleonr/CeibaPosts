//
//  Post.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation

class Post: Codable, Equatable {
        static func == (lhs: Post, rhs: Post) -> Bool {
            return lhs.body == rhs.body && lhs.favourite == lhs.favourite && rhs.id == lhs.id && rhs.readed == lhs.readed && rhs.title == lhs.title && rhs.userId == lhs.userId
        }
    
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    var readed: String?
    var favourite: String?
    
    init() {
    }
    
    init(userId: Int?, id: Int?, title: String?, body: String?, readed: String?, favourite: String?) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.readed = readed
        self.favourite = favourite
    }
}

