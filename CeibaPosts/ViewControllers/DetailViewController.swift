//
//  DetailViewController.swift
//  CeibaPosts
//
//  Created by Matt Leon on 10/24/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    var user: User!
    var posts: [Post] = []
    let disposeBag = DisposeBag()
    let userPostsViewModel = UserPostsViewModel()
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bind()
        // Do any additional setup after loading the view.
    }
    

    func setUI() {
        userName.text = user?.name
        userEmail.text = user?.email
        userPhone.text = user?.phone
    }
    
    func bind() {
        userPostsViewModel.input.userId.accept("\(user.id ?? 0)")
        userPostsViewModel.output.posts.asObservable().subscribe(
        onNext: { posts in
            self.cleanTable()
            for post in posts ?? [] {
                self.posts.append(post)
                self.updateTable()
            }

        }).disposed(by: disposeBag)
    }
    
    func cleanTable() {
        postsTableView.endUpdates()
        posts.removeAll()
        postsTableView.reloadData()
    }
    
    func updateTable() {
        let indexPath = IndexPath(row: posts.count - 1, section: 0)

        postsTableView.beginUpdates()
        postsTableView.insertRows(at: [indexPath], with: .automatic)
        postsTableView.endUpdates()
    }
    

}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.setCell(post: post)
        return cell
    }
    
}
