//
//  CeibaBLBehavior.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import RxSwift

protocol CeibaBLBehavior {
    func getPosts(id: String) throws -> Observable<[Post]>
    func getUsers() throws -> Observable<[User]>
}
