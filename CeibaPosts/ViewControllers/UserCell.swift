//
//  UserCell.swift
//  CeibaPosts
//
//  Created by Mateo Leon Restrepo on 24/10/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    func setCell(user: User) {
        userNameLabel.text = user.name
        userPhoneLabel.text = user.phone
        userEmailLabel.text = user.email
    }
    
}
