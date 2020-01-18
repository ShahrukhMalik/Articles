//
//  ArticleRemoteRepositoryTests.swift
//  ArticlesTests
//
//  Created by Shah Rukh Malik on 10/10/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import XCTest
@testable import Articles

class ArticleRemoteRepositoryTests: XCTestCase {
    
    var sut: ArticleRemoteRepository!
    var stubService: StubServiceApi!
    var stubCoreData: StubCoreDataManager!
    var jsonArticlessDictionaryStub : Dictionary<String,AnyObject>!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        jsonArticlessDictionaryStub = loadJSONDictionaryFromBundle(withName: "Articles", extension: "json")
        
        stubService = StubServiceApi()
        stubCoreData = StubCoreDataManager()
        sut = ArticleRemoteRepository(aServiceApI: stubService, aCoreDataManager: stubCoreData)
        
        
        stubService.session = StubURLSession()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func testShouldReturnLoadedJSON() {
          XCTAssertNotNil(jsonArticlessDictionaryStub)
      }
      
     

      
      func testShouldReturnArticles() {
          DummyReachability.isConnected = true

          let jsonString:String = jsonArticlessDictionaryStub.jsonStringRepresentation!
           let session = stubService.session as! StubURLSession
              session.nextData = jsonString.data(using: .utf8)
              let request = Request.Fetch.ArticleRequest(pageNumber: 0)
              session.nextResponse = HTTPURLResponse(url: URL(string: request.mURL)!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
              sut?.fetchArticless(request: Request.Fetch.ArticleRequest(pageNumber: 0), complete: { (article) in
                  XCTAssertNotNil(article)
              }, failure: { (error) in
                  XCTFail()
              })
          

      }
      
      func testShouldReturnErrorOfMappingArticles() {
          DummyReachability.isConnected = true
          let session = stubService.session as! StubURLSession

          session.nextData = "".data(using: .utf8)
          let request = Request.Fetch.ArticleRequest(pageNumber: 0)
          session.nextResponse = HTTPURLResponse(url: URL(string: request.mURL)!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
          sut?.fetchArticless(request: Request.Fetch.ArticleRequest(pageNumber: 0), complete: { (article) in
              XCTFail()

          }, failure: { (error) in
              XCTAssertEqual(error, "The data couldn’t be read because it isn’t in the correct format.")

          })
          
      }
}
