//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Shahrukh Malik on 10/8/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var dateImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}
