//
//  StubArticlesRemoteWorker.swift
//  ArticlesDemoAppTests
//
//  Created by Shah Rukh Malik on 9/8/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import Foundation

@testable import Articles

class StubArticlesRemoteRepository: ArticleRemoteRepository {

    var shouldFailOnFetch:Bool = false
    var dataToReturnOnSuccess:ArticleListModel?
    var isRemoteRepoCalled = false
    var isCoreDataRequestMade = false
    var coreDataReqFailed: Bool = false
    
    override func fetchArticless(request: Request.Fetch.ArticleRequest, complete: @escaping (ArticleListModel) -> Void, failure: @escaping (String?) -> Void) {
        
        isRemoteRepoCalled = true
        if shouldFailOnFetch {
            failure(NetworkError.other("Test failing").localizedDescription)
        } else {
            if let data = dataToReturnOnSuccess {
                complete(data)
            }
        }
    }
    
    override func fetchRecentSearches() -> [RecentSearchModel]? {
        isCoreDataRequestMade = true
        
        if coreDataReqFailed {
            return nil
        }
        
        return nil
    }
    
    
    
    
    
}
