//
//  postCell.swift
//  CeibaPosts
//
//  Created by Matt Leon on 10/24/20.
//  Copyright © 2020 Matt Leon. All rights reserved.
//

import Foundation
import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    func setCell(post: Post) {
        bodyLabel.text = post.body
        titleLabel.text = post.title
    }
    
}
