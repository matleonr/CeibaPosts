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
    var postsDB: Connection!
    var path: String = "CeibaPostsDB.sqlite3"
    let postTable = Table("posts")

    let userId = Expression<Int>("userId")
    let id = Expression<Int>("id")
    let title = Expression<String>("title")
    let body = Expression<String>("body")
    let readed = Expression<String>("readed")
    let favourite = Expression<String>("favourite")
    

    init() {
        postsDB = createDatabase()
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
        let tableToCreate = postTable.create { table in
            table.column(userId)
            table.column(id)
            table.column(title)
            table.column(body)
            table.column(readed)
            table.column(favourite)
        }

        do {
            try postsDB.run(tableToCreate)
            print("table created hellyeah")
        } catch {
            print(error)
        }
    }
    
    
    func updateReaded(id: Int) {
        let postFromDb = postTable.filter(self.id == id)
        let postUpdate = postFromDb.update(readed <- "yes")
        do {
            try postsDB.run(postUpdate)
            print("post updated")
        } catch {
            print(error)
        }
    }
    
    func updateFavourite(id: Int) {
        let postFromDb = postTable.filter(self.id == id)
        let postUpdate = postFromDb.update(favourite <- "yes")
        do {
            try postsDB.run(postUpdate)
            print("post updated")
        } catch {
            print(error)
        }
    }

    
    func postTableHasData() -> Bool {
        var validate = false
        if getPosts().count > 0 {
            validate = true
        }
        return validate
    }
    
    func create(post: Post) {
        let postToInsert = postTable.insert(id <- post.id!, userId <- post.userId!, title <- post.title!, body <- post.body!, readed <- post.readed!, favourite <- post.favourite!)
        do {
            try postsDB.run(postToInsert)

            print("post registered successfully")
        } catch {
            print(error)
        }
    }
    
    func getFavourites() -> [Post] {
        var favouritePostsArray = [Post]()
        let favouritePostsSelect = postTable.filter(favourite == "yes")
        do {
            let favourites = try postsDB.prepare(favouritePostsSelect)
            for post in favourites {
                let favouriteScoped = Post(userId: post[userId], id: post[id], title: post[title], body: post[body], readed: post[readed], favourite: post[favourite])
                favouritePostsArray.append(favouriteScoped)
            }
            return favouritePostsArray
        } catch  {
            print(error)
            return favouritePostsArray
        }
    }

    func getPosts() -> [Post] {
        var postsArray = [Post]()

        do {
            let posts = try postsDB.prepare(postTable)

            for post in posts {
                

                let postScoped = Post(userId: post[userId], id: post[id], title: post[title], body: post[body], readed: post[readed], favourite: post[favourite])

                postsArray.append(postScoped)
            }
            return postsArray
        } catch {
            print(error)
            return postsArray
        }
    }

    func getPost(postId: Int) -> Post? {
        let postFromDb = postTable.filter(id == postId)
        var post: Post?
        do {
            for postGetted in try postsDB.prepare(postFromDb) {
                post = Post(userId: postGetted[userId], id: postGetted[id], title: postGetted[title], body: postGetted[body], readed: postGetted[readed], favourite: postGetted[favourite])
                return post
            }

        } catch {
            print(error)
        }
        return post
    }

    func update(post: Post) {
        let postFromDb = postTable.filter(id == post.id!)
        let postUpdate = postFromDb.update( userId <- post.userId!, title <- post.title!, body <- post.body!, readed <- post.readed!, favourite <- post.favourite!)
        do {
            try postsDB.run(postUpdate)
            print("post updated")
        } catch {
            print(error)
        }
    }

    func delete(postId: Int) {
        let postFromDb = postTable.filter(id == postId)
        let postDelete = postFromDb.delete()
        do {
            try postsDB.run(postDelete)
        } catch {
            print(error)
        }
    }
    
    func deleteAll() {
        
        let postDelete = postTable.delete()
        do {
            try postsDB.run(postDelete)
        } catch {
            print(error)
        }
        
    }
}
