//
//  UsersViewModel.swift
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

class UsersViewModel : ViewModelProtocol{
    let disposeBag = DisposeBag()
    let usersDB = DBHelper()
    var ceibaBl: CeibaBLBehavior
    
    struct Input {
        var viewShown = BehaviorRelay<Bool?>(value: false)
    }
    
    struct Output {
        var users = BehaviorRelay<[User]?>(value: nil)
        var loading = BehaviorRelay<Bool?>(value: false)
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
        output.loading.accept(true)
        input.viewShown.subscribe(onNext: { shown in

            if shown ?? false {
                if !self.usersDB.usersTableHasData() {
                    self.getUsersFromApi()
                }
            
                self.showUsers()
            }

        }).disposed(by: disposeBag)
        
    }
    
    func getUsersFromApi() {
        do {
            try ceibaBl.getUsers().asObservable().retry(1).subscribe(onNext: { response in

                let users = response

                for user in users {
    
                    self.usersDB.create(user: user)
                    
                }
                self.showUsers()

            })

        } catch {
            print("Error", "No se pudo cargar el servicio")
        }
    }
    
    func showUsers() {
        output.users.accept(usersDB.getUsers())
        output.loading.accept(false)
    }
}
