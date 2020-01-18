//
//  ArticlesListViewModelTests.swift
//  ArticlesTests
//
//  Created by Shah Rukh Malik on 10/9/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import XCTest
@testable import Articles

class ArticlesListViewModelTests: XCTestCase {
    
    var sut: ArticlesListViewModel!
    var stubRepo:StubArticlesRemoteRepository!
    
    var stubService: StubServiceApi!
    var stubCoreData: StubCoreDataManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        stubService = StubServiceApi()
        stubCoreData = StubCoreDataManager()
        
        stubRepo = StubArticlesRemoteRepository(aServiceApI: stubService, aCoreDataManager: stubCoreData)

        sut = ArticlesListViewModel()
        sut.repo = stubRepo
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testConstants() {
        XCTAssertNotNil(sut.screenTitle)
        XCTAssertNotNil(sut.searchImage)
        XCTAssertNotNil(sut.dotImage)
    }
    
    func testFetchArticles() {
        sut.fetchArticles(request: Request.Fetch.ArticleRequest(pageNumber: 0))
        XCTAssertTrue(stubRepo.isRemoteRepoCalled)
    
    }
    
    func testFetchArticlesDataShouldReturnError() {
        stubRepo.shouldFailOnFetch = true
        sut.fetchArticles(request: Request.Fetch.ArticleRequest(pageNumber: 0))
        
        XCTAssertNotNil(sut.error)
    }
    
    func testFetchArticlesDataShouldNotReturnError() {
        stubRepo.dataToReturnOnSuccess = StubArticleListModel.dummyArticleListModel()
        sut.reloadTableViewClosure =  { [weak self] (viewModelList) in
        
        }
        sut.fetchArticles(request: Request.Fetch.ArticleRequest(pageNumber: 0))
        
        XCTAssertNotNil(sut.articleViewModels)
       
    }
    
    func testRecentSearches() {
        sut.fetchRecentSearches()
        XCTAssertTrue(stubRepo.isCoreDataRequestMade)
    }
    
    func testrecentSearchesFail() {
        stubRepo.coreDataReqFailed = true
        XCTAssertNil(stubRepo.fetchRecentSearches())
    }
    
    func testRecentSearchTermClicked() {
        let searchTerm = "Hi"
        sut.searchTermClicked(searchTerm: searchTerm)
        XCTAssertEqual(searchTerm, sut.searchString)
    }
    
    func testFilterScreenWithSearchText(search:  String) {
        sut.filterArticleViewModelWithText(searchText: "")
        XCTAssertEqual(sut.filteredArticleViewModels, sut.articleViewModels)
    }
}
