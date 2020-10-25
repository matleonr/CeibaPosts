//
//  CeibaPostsTests.swift
//  CeibaPostsTests
//
//  Created by Matt Leon on 10/22/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

@testable import Ceiba_Posts
import RxCocoa
import RxSwift
import RxTest
import XCTest

class fakeSuccessfullBL: CeibaBL {
    override init() {
        super.init()
    }

    override func getUsers() throws -> Observable<[User]> {
        var response = [User]()

        let user1 = User(id: 1, name: "Matt Leon", username: "ModularMatt", email: "mateo.vivo@gmail.com", phone: "(+57) 314 550 3339", website: "modularsoftware.com")
        let user2 = User(id: 2, name: "Maria Camila Chica", username: "AstrolabioMusic", email: "mariacamilacg48@gmail.com", phone: "(+57) 312 322 4568", website: "astrolabio.com")
        let user3 = User(id: 3, name: "Manolo L", username: "manolete", email: "manolo@gmail.com", phone: "(+57) 312 243 6220", website: "iso100producciones.com")

        response.append(user1)
        response.append(user2)
        response.append(user3)
        return Observable<[User]>.from(optional: response)
    }

    override func getPosts(id: String) throws -> Observable<[Post]> {
        var response = [Post]()

        let post1 = Post(userId: 1, id: 1, title: "Post Decente", body: "por fin un post decente y no un lorem ipsum que no se entiende nada")
        let post2 = Post(userId: 1, id: 2, title: "lorem ipsum :/", body: "no mentiras, este tampoco es lorem ipsum")
        let post3 = Post(userId: 1, id: 3, title: "hola como estas?", body: "y tuve un impedimento con otra reunion que tenia atravezada, pero ya se acabo ya me estoy documentando sobre la inyeccion de dependencias")

        let post4 = Post(userId: 2, id: 4, title: "mensaje de whatsapp", body: "Si por ahí se suscriben estaría genial voy a hacer un review de la guitarra ya bien con pros y contras en diciembre me compro la nueva")
        let post5 = Post(userId: 2, id: 5, title: "ahora entiendo por que lorem ipsum", body: "um has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letras")
        let post6 = Post(userId: 2, id: 6, title: " long established fact that a read", body: "d not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets cont")
        response.append(post1)
        response.append(post2)
        response.append(post3)
        response.append(post4)
        response.append(post5)
        response.append(post6)
        return Observable<[Post]>.from(optional: response)
    }
}

class UsersViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposebag: DisposeBag!
    
    override func setUp() {
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposebag =  DisposeBag()
    }
    
    
    func testGetUsers() {
        let fakeBL = fakeSuccessfullBL()
        let viewModel = UsersViewModel(ceibaBL: fakeBL)
        viewModel.input.viewShown.accept(true)
        
        let users = scheduler.createObserver([User]?.self)
        viewModel.output.users.asDriver().drive(users).disposed(by: disposebag)
        
        scheduler.start()
        
        let usersGetted = viewModel.output.users.value
        let fakeUsers = createUsers()
        
        XCTAssert(usersGetted![0] == fakeUsers[0])
    }
    
    
    func createUsers() -> [User] {
        var users = [User]()
        
        let user1 = User(id: 1, name: "Matt Leon", username: "ModularMatt", email: "mateo.vivo@gmail.com", phone: "(+57) 314 550 3339", website: "modularsoftware.com")
        let user2 = User(id: 2, name: "Maria Camila Chica", username: "AstrolabioMusic", email: "mariacamilacg48@gmail.com", phone: "(+57) 312 322 4568", website: "astrolabio.com")
        let user3 = User(id: 3, name: "Manolo L", username: "manolete", email: "manolo@gmail.com", phone: "(+57) 312 243 6220", website: "iso100producciones.com")
        
        users.append(user1)
        users.append(user2)
        users.append(user3)
        
        return users
    }
}
