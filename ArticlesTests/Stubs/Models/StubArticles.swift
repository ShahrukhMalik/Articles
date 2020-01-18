//
//  StubArticles.swift
//  ArticlesDemoAppTests
//
//  Created by Shah Rukh Malik on 9/8/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import Foundation

@testable import Articles

class StubArticleListModel: ArticleListModel {
    
    static func dummyArticleListModel() -> ArticleListModel {
        return ArticleListModel(status: "status", copyright: "Test", response: StubResponse.dummyResponseModel())
    }
}
