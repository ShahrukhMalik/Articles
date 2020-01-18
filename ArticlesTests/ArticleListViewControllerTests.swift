//
//  ArticleListViewControllerTests.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import XCTest
@testable import Articles


class ArticleListViewControllerTests: XCTestCase {
    
    var sut: ArticlesListViewController!
    var stubContainerView:UIView!
    var dummySearchBar: UISearchBar!
    var dummyViewModel: ArticlesListViewModel!
    
    override func setUp() {
        super.setUp()
        sut = (UIStoryboard.viewController(screenName:"ArticlesListViewController", storyboardName: "Main") as! ArticlesListViewController)
        
        dummyViewModel = ArticlesListViewModel()
        dummySearchBar = UISearchBar()
        
        sut.articlesListViewModel = dummyViewModel
        sut.searchBar = dummySearchBar
        
        stubContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        sut.containerView = stubContainerView
        //        sut.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        stubContainerView = nil
        super.tearDown()
    }
    
    func testHandleSearch() {
        dummyViewModel.isSearchVisible = false
        sut.handleSearch()
        XCTAssert(dummyViewModel.isSearchVisible)
    }
    
    func testRemoveRecentScreenOnCloseSerch() {
        sut.closeSearch()
        XCTAssertNil(sut.recentViewController)
    }
    
    func testShowRecentScreen() {
        sut.showRecentScreen(show: true)
        XCTAssertNotNil(sut.recentViewController)
    }
    
    func testHideRecentScreen() {
        sut.showRecentScreen(show: false)
        XCTAssertNil(sut.recentViewController)
    }
    
    func testShowRecentScreenOnSearchBarFocus() {
        XCTAssert(sut.searchBarShouldBeginEditing(UISearchBar()))
    }
    
    func testUpdateSearchFieldWithText() {
        let searchText = "Hello"
        sut.updateSearchFieldWithText(search: searchText)
        XCTAssertEqual(searchText, sut.searchBar.text)
    }
}
