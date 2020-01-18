//
//  CoreDataManagerTests.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import XCTest
@testable import Articles

class CoreDataManagerTests: XCTestCase {
    
    var dataManager:CoreDataManager!
    
    override func setUp() {
        dataManager = CoreDataManager()
        // add dummy values in CoreData to test the fetching
        dataManager.insertSearchTerm(searchTerm: "hi", withDate: Date())
    }
    
    func testFetchDataFromCoreData() {
        let expectation = self.expectation(description: "Will fetch the Data from CoreData")
        if let values = dataManager.fetchRecentSearches() {
            if values.count > 0
            {
                XCTAssertNotNil(values)
                XCTAssertEqual(values.first?.term, "hi")
                expectation.fulfill()
                
            } else {
                XCTFail("Not able to fetch the data from coreData")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testFailToFetchDataFromCoreData() {
        let expectation = self.expectation(description: "Will fetch the Data from CoreData")
        if let values = dataManager.fetchRecentSearches() {
            if values.count > 0
            {
                XCTAssertNotNil(values)
                XCTAssertNotEqual(values.first?.term, "Hello")
                expectation.fulfill()
                
            } else {
                XCTFail("Not able to fetch the data from coreData")
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testPersistentStoreCoordinator() {
        XCTAssertNotNil(dataManager.persistentContainer)
    }

    
    
}
