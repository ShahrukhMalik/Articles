//
//  Response.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

class Response: Codable {
    let articles: [ArticleModel]
    
    enum CodingKeys: String, CodingKey {
        case articles = "docs"
    }
    
    init(docs: [ArticleModel]) {
        self.articles = docs
    }
}
