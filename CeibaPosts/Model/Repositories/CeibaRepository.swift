//
//  CeibaRepository.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Alamofire
import Foundation
import Moya
import RxSwift

class CeibaRepository: CeibaRepositoryBehavior {
    
    let ceibaApi = MoyaProvider<CeibaApi>(session :  Alamofire.Session.init())
    func getUsers() throws -> Observable<[User]> {
        ceibaApi.rx.request(CeibaApi.getUsers).asObservable().flatMap({ Response -> Observable<[User]> in
            
            if Response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let resultGetUsers = try decoder.decode([User].self, from: Response.data)
                    return Observable.just(resultGetUsers)
                }
            } else {
                let error = NSError(domain: "Error napoleonApi", code: Response.statusCode, userInfo: ["Error": Response.statusCode.description])
                return Observable.error(error)
            }
        })
    }
    
    func getPosts(id: String) throws -> Observable<[Post]> {
        return ceibaApi.rx.request(CeibaApi.getPosts(id: id)).asObservable().flatMap({ Response -> Observable<[Post]> in

            if Response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let resultGetPosts = try decoder.decode([Post].self, from: Response.data)
                    return Observable.just(resultGetPosts)
                }
            } else {
                let error = NSError(domain: "Error napoleonApi", code: Response.statusCode, userInfo: ["Error": Response.statusCode.description])
                return Observable.error(error)
            }

        })
    }
    
}
