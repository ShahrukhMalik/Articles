//
//  StubResult.swift
//  ArticlesDemoAppTests
//
//  Created by Shah Rukh Malik on 9/9/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import Foundation

@testable import Articles
class StubArticleModel: ArticleModel {
    
    static func dummyArticle() -> ArticleModel  {
        return ArticleModel(abstract: "A",
                            snippet: "S",
                            multimedia: [StubMultimedia.dummyMultimedia()],
                            headline: StubHeadline.dummyHeadline(),
                            pubDate: "Date")
    }
}
