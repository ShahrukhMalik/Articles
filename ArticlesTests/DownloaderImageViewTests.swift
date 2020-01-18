//
//  DownloaderImageViewTests.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import XCTest
@testable import Articles

class DownloaderImageViewTests: XCTestCase {
    
    
    var sut: StubDownloaderImageView!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        sut = StubDownloaderImageView()
        sut.image = UIImage(named: "Placeholder")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testImageDownloadCalled() {
        sut.loadImageUsingUrlString(urlString: "")
        XCTAssertTrue(sut.isLoadImageURLCalled)
    }
    
    func testPlaceholderImageWrongUrlString() {
        sut.loadImageUsingUrlString(urlString: "")
        XCTAssertEqual(sut.image, UIImage(named: "Placeholder"))
    }
}
