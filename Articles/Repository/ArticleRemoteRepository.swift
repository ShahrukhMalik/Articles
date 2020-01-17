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
