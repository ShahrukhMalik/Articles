//
//  ArticleRemoteRepository.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class ArticleRemoteRepository {
    
    var serviceApi:ServiceApi!
    var coreDataManager: CoreDataManager!
    
    func fetchRecentSearches() -> [RecentSearchModel]? {
        
        if coreDataManager == nil {
            coreDataManager = CoreDataManager()
        }
        
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
    
    func insertSearchTerm(searchterm: String, date: Date) {
        
        if coreDataManager == nil {
            coreDataManager = CoreDataManager()
        }
        
        coreDataManager.insertSearchTerm(searchTerm: searchterm, withDate: date)
    }
    
    func fetchArticless(request:Request.Fetch.ArticleRequest , complete :@escaping (ArticleListModel) -> Void, failure:@escaping (String?) -> Void) {
        
        if serviceApi == nil {
            serviceApi = ServiceApi()
        }
        
        print("Request : \(request.mURL)")
        
        serviceApi.getData(url: request.mURL, withMethod: .GET) {  (response, error) in
            guard error == nil else {
                failure(error?.localizedDescription)
                return
            }
            
            if let mData = response as? Data {
                do {
                    let article = try JSONDecoder().decode(ArticleListModel.self, from: mData)
                    complete(article)
                } catch  {
                    failure(error.localizedDescription)
                }
            }
        }
    }
}
