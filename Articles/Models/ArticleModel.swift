//
//  ArticleModel.swift
//  Articles
//
//  Created by Shahrukh Malik on 10/8/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import Foundation

class ArticleModel: Codable {
    let abstract: String
    let snippet: String
    let multimedia: [Multimedia]
    let headline: Headline
    let pubDate: String
    
    enum CodingKeys: String, CodingKey {
        case abstract
        case snippet
        case multimedia
        case headline
        case pubDate = "pub_date"
    }
    
    init(abstract: String, snippet: String, multimedia: [Multimedia], headline: Headline, pubDate: String) {
        self.abstract = abstract
        self.snippet = snippet
        self.multimedia = multimedia
        self.headline = headline
        self.pubDate = pubDate
    }
}
