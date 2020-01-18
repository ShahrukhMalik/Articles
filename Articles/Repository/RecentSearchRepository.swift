//
//  RecentSearchRepository.swift
//  Articles
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class RecentSearchRepository {
    
    var coreDataManager: CoreDataManager!
    
    init(aCoreDataManager: CoreDataManager) {
        coreDataManager = aCoreDataManager
    }
    
    func insertSearchTerm(searchterm: String, date: Date) {
        coreDataManager.insertSearchTerm(searchTerm: searchterm, withDate: date)
    }
    
    func fetchRecentSearches() -> [RecentSearchModel]? {
        var models = [RecentSearchModel]()
        
        let searchManagedObjects = coreDataManager.fetchRecentSearches()
        
        if let searchObjects = searchManagedObjects {
            
            for search in searchObjects {
                let search = RecentSearchModel(aTerm: search.term ?? "", aDate: search.date! as Date)
                models.append(search)
            }
        }
        
        return models
    }
}
