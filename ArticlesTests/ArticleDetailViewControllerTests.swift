//
//  ArticleDetailViewControllerTests.swift
//  ArticlesTests
//
//  Created by Shah Rukh Malik on 10/10/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import XCTest
@testable import Articles


class ArticleDetailViewControllerTests: XCTestCase {

    var sut: ArticleDetailViewController!
    var stubLabel:UILabel!
    var stubImageView: DownloaderImageView!
    
    override func setUp() {
        super.setUp()
        sut = (UIStoryboard.viewController(screenName:"ArticleDetailViewController", storyboardName: "Main") as! ArticleDetailViewController)
        
        let dummyViewModel = ArticleViewModel(title: "Title",
                                            snippet: "Snippet",
                                            publishedDate: "2020-01-22T00:00:00+0000",
                                            imageURLString: "")
        
        stubLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        stubImageView = DownloaderImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        sut.articleViewModel = dummyViewModel
        
        sut.abstractLabel = stubLabel
        sut.titleLabel = stubLabel
        sut.subTitleLabel = stubLabel
        sut.mainImageView = stubImageView
//        sut.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        stubLabel = nil
        stubImageView = nil
        super.tearDown()
    }
    
    func testTitlePopulatedWithViewModelNotNil() {
        sut.configureViewUsingViewModel(viewModel: sut.articleViewModel)
        XCTAssertNotNil(sut.titleLabel.text)
        XCTAssertNotNil(sut.subTitleLabel.text)
    }
    
    
}
