//
//  ViewController.swift
//  CeibaPosts
//
//  Created by Matt Leon on 10/22/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let usersViewModel = UsersViewModel()
    var users: [User] = []

    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        bind()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersViewModel.input.viewShown.accept(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usersViewModel.input.viewShown.accept(false)
        
    }
    
    func bind() {
        usersViewModel.output.users.asObservable().subscribe(
        onNext: { users in
            self.cleanTable()
            for user in users ?? [] {
                self.users.append(user)
                self.updateTable()
            }

        }).disposed(by: disposeBag)
    }
    
    func cleanTable() {
        usersTableView.endUpdates()
        users.removeAll()
        usersTableView.reloadData()
    }
    
    func updateTable() {
        let indexPath = IndexPath(row: users.count - 1, section: 0)

        usersTableView.beginUpdates()
        usersTableView.insertRows(at: [indexPath], with: .automatic)
        usersTableView.endUpdates()
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setCell(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let user = users[indexPath.row]
        
        
    }
}

