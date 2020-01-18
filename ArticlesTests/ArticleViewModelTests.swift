//
//  ArticleViewModelTests.swift
//  ArticlesTests
//
//  Created by Shah Rukh Malik on 10/9/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import XCTest
@testable import Articles

class ArticleViewModelTests: XCTestCase {
    
    var articleViewModel: ArticleViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        articleViewModel = ArticleViewModel(title: "T", snippet: "S", publishedDate: "2020-01-22T00:00:00+0000", imageURLString: "I")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        articleViewModel = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testArticleViewModelInit() {
        articleViewModel = ArticleViewModel(title: "T", snippet: "S", publishedDate: "2020-01-22T00:00:00+0000", imageURLString: "I")
        XCTAssertNotNil(articleViewModel)
    }
    
    func testImageRenderingTypeAlwaysTemplate() {
        XCTAssert(articleViewModel.dateImage?.renderingMode == .alwaysTemplate)
    }
    
    func testScreenTitle() {
        XCTAssert(articleViewModel.screenTitle == "Detail")
    }
}
