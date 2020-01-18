//
//  ArticlesUITests.swift
//  ArticlesUITests
//
//  Created by Shahrukh Malik on 1/15/20.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import XCTest

class ArticlesUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testShouldGoToArticleDetail() {
        sleep(5)
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
    }
}
