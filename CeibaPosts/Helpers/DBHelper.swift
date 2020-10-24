//
//  DBHelper.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import SQLite

class DBHelper {
    var usersDB: Connection!
    var path: String = "CeibaPostsDB.sqlite3"
    let usersTable = Table("users")

    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let username = Expression<String>("username")
    let email = Expression<String>("email")
    let phone = Expression<String>("phone")
    let website = Expression<String>("website")
    

    init() {
        usersDB = createDatabase()
        createTablePosts()
    }

    func createDatabase() -> Connection! {
        do {
            let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathExtension(path)

            let db = try Connection(filepath.path)
            print("database created with path \(filepath.path)")
            return db
        } catch {
            print(error)
            return nil
        }
    }

    func createTablePosts() {
        let tableToCreate = usersTable.create { table in
            table.column(id)
            table.column(name)
            table.column(username)
            table.column(email)
            table.column(phone)
            table.column(website)
        }

        do {
            try usersDB.run(tableToCreate)
            print("table created hellyeah")
        } catch {
            print(error)
        }
    }
    


    
    func usersTableHasData() -> Bool {
        var validate = false
        if getUsers().count > 0 {
            validate = true
        }
        return validate
    }
    
    func create(user: User) {
        let userToInsert = usersTable.insert(id <- user.id!,name <- user.name!,username <- user.username!, email <- user.email!, phone <- user.phone!, website <- user.website!)
            
        do {
            try usersDB.run(userToInsert)

            print("user registered successfully")
        } catch {
            print(error)
        }
    }
    
    

    func getUsers() -> [User] {
        var usersArray = [User]()

        do {
            let users = try usersDB.prepare(usersTable)

            for user in users {
                

                let userScoped = User(id: user[id], name: user[name], username: user[username], email: user[email], phone: user[phone], website: user[website])
                    
                

                usersArray.append(userScoped)
            }
            return usersArray
        } catch {
            print(error)
            return usersArray
        }
    }

    func getUser(usrId: Int) -> User? {
        let userFromDb = usersTable.filter(id == usrId)
        var user: User?
        do {
            for userGetted in try usersDB.prepare(userFromDb) {
                user = User(id: userGetted[id], name: userGetted[name], username: userGetted[username], email: userGetted[email], phone: userGetted[phone], website: userGetted[website])
                    
                return user
            }

        } catch {
            print(error)
        }
        return user
    }

   


    

}
