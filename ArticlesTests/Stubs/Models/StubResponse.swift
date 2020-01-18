//
//  StubResponse.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

@testable import Articles

class StubResponse: Response {
    
    static func dummyResponseModel() -> Response {
        return Response(docs: [StubArticleModel.dummyArticle()])
    }
    
}
