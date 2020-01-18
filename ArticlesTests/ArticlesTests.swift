//
//  ArticlesTests.swift
//  ArticlesTests
//
//  Created by Shah Rukh Malik on 10/9/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import XCTest
@testable import Articles

class ArticlesTests: XCTestCase {
    
    var storyboard : UIStoryboard?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.storyboard = nil
        super.tearDown()
    }
    
    func testStoryboard() {
        XCTAssertNotNil(self.storyboard)
    }
    
    func testCustomNavigationController() {
        let navController = self.storyboard?.instantiateViewController(withIdentifier: "CustomNavigationController")
        
        XCTAssertNotNil(navController)
        XCTAssertTrue(navController is CustomNavigationController)
    }
    
    func testArticleListView() {
        let articlesListViewController = self.storyboard?.instantiateViewController(withIdentifier: "ArticlesListViewController")
        
        XCTAssertNotNil(articlesListViewController)
        XCTAssertTrue(articlesListViewController is ArticlesListViewController)
        
    }
    
    func testArticleDetailView() {
        let articleDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailViewController")
        
        XCTAssertNotNil(articleDetailViewController)
        XCTAssertTrue(articleDetailViewController is ArticleDetailViewController)
        
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

}
