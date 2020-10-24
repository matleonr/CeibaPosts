//
//  postCell.swift
//  CeibaPosts
//
//  Created by Matt Leon on 10/24/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import UIKit

class postCell: UITableViewCell {
    
    func setCell(user: User) {
        userNameLabel.text = user.name
        userPhoneLabel.text = user.phone
        userEmailLabel.text = user.email
    }
    
}
