//
//  CeibaBL.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import RxSwift

class CeibaBL: CeibaBLBehavior {
    
    var ceibaRepository: CeibaRepositoryBehavior
    
    
    init(repository: CeibaRepositoryBehavior) {
        ceibaRepository = repository
    }
    
    init(){
        ceibaRepository = CeibaRepository()
    }
    func getUsers() throws -> Observable<[User]> {
        return try ceibaRepository.getUsers().asObservable().flatMap({
            response -> Observable<[User]> in
            Observable.just(response)
        })
    }

}
