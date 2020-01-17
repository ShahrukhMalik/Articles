//
//  ArticleListModel.swift
//  Articles
//
//  Created by Shahrukh Malik on 10/9/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import Foundation

class ArticleListModel: Codable {
    
    let status, copyright: String
    let response: Response
    
    enum CodingKeys: String, CodingKey {
        case status, copyright
        case response
    }
    
    init(status: String, copyright: String, response: Response) {
        self.status = status
        self.copyright = copyright
        self.response = response
    }
}
