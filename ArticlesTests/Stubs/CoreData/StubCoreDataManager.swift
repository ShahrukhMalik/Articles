//
//  StubCoreDataManager.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import XCTest
@testable import Articles


class StubCoreDataManager: CoreDataManager  {
    
    override func insertSearchTerm(searchTerm: String, withDate date: Date) {
        
    }
    
    override func fetchRecentSearches() -> [Search]? {
        return nil
    }
}
