//
//  RequestModel.swift
//  ArticlesDemoApp
//
//  Created by Shahrukh Malik on 9/11/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import Foundation

let APIURLPrefix = "https://api.nytimes.com/svc/"

enum Request {
    
    enum Fetch
    {
        struct ArticleRequest
        {
            var pageNumber: Int = 0
            
            private var countryName: String {
                return "singapore"
            }
            
            private var apiKey:String {
                return "5763846de30d489aa867f0711e2b031c"
            }
            
            var mURL: String {
                let url = String(format: APIURLPrefix + "search/v2/articlesearch.json?api-key=\(apiKey)&q=\(countryName)&page=\(pageNumber)")
                return url
            }
        }
    }
}
