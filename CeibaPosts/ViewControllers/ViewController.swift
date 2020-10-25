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
    var filteredUsers = [User]()
    var searching = false
    var alert = UIAlertController()

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
        searching = false
        usersViewModel.input.viewShown.accept(false)
        userSearchBar.searchTextField.text = ""
        userSearchBar.endEditing(true)
        
    }
    
    func showAlert(message:String) {
        alert = UIAlertController(title: message,
                                                message: nil,
                                                preferredStyle: .alert)
        present(alert, animated: true){
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            self.alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    func dismissAlert() {
        alert.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissAlertController(){
        userSearchBar.searchTextField.text = ""
        searching=false
        usersTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        userSearchBar.endEditing(true)
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
        usersViewModel.output.loading.asObservable().subscribe(
            onNext: { loading in
                if loading ?? false {
                    self.showAlert(message: "Obteniendo informacion...")
                }else{
                    self.dismissAlert()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserPosts" {
            let postsVC = segue.destination as! DetailViewController
            postsVC.user = sender as? User
        }
        
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching{
            if filteredUsers.count == 0 {
                self.showAlert(message: "List is empty")
            }
            return filteredUsers.count
        }else{
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var user = User()
        if searching{
            user = filteredUsers[indexPath.row]
        }else{
            user = users[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.setCell(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = User()
        if searching {
            user = filteredUsers[indexPath.row]
        }else{
            user = users[indexPath.row]
        }
            

        performSegue(withIdentifier: "UserPosts", sender: user)
        
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searching = false
            usersTableView.reloadData()
        }else{
            filteredUsers = users.filter({ (user) -> Bool in
                return (user.name?.contains(searchText))!
            })
            searching = true
            usersTableView.reloadData()
        }
        
    }
}

