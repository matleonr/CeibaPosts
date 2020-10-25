//
//  UserPostsViewModel.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Alamofire
import Foundation
import Moya
import RxCocoa
import RxSwift

class UserPostsViewModel : ViewModelProtocol{
    
    let disposeBag = DisposeBag()
    let usersDB = DBHelper()
    var ceibaBl: CeibaBLBehavior
    
    struct Input {
        var viewShown = BehaviorRelay<Bool?>(value: false)
        var userId = BehaviorRelay<String?>(value: nil)
    }
    
    struct Output {
        var posts = BehaviorRelay<[Post]?>(value: nil)
    }

    let input: Input
    let output: Output

    
    init(ceibaBL: CeibaBLBehavior) {
        input = Input()
        output = Output()
        self.ceibaBl = ceibaBL
        bind()
    }

    init() {
        input = Input()
        output = Output()
        ceibaBl = CeibaBL(repository: CeibaRepository())
        bind()
    }
    
    func bind() {
        input.userId.subscribe(onNext: { id in

            if id != nil {
                
                self.getUserPostsFromApi(id: id!)
        
            }

            }).disposed(by: disposeBag)
        
    }
    
    func getUserPostsFromApi(id: String) {
        do {
            try ceibaBl.getPosts(id: id).asObservable().retry(1).subscribe(onNext: { response in

                let posts = response

                self.output.posts.accept(posts)
                

            })

        } catch {
            print("Error", "No se pudo cargar el servicio")
        }
    }
}
