//
//  ArticleViewModel.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class ArticleViewModel: NSObject {
    var screenTitle: String {
        return "Detail"
    }
    
    var dateImage: UIImage? {
        return UIImage(named: "Calendar")!.withRenderingMode(.alwaysTemplate)
    }
    
    var formattedDateString: String {
        return String.formattedDateFromDateString(dateString: publishedDate)
    }
    
    let title: String!
    let snippet: String!
    let publishedDate: String!
    let imageURLString: String?
    
    
    init(title: String,
         snippet: String,
         publishedDate: String,
         imageURLString: String?) {
        self.title = title
        self.snippet = snippet
        self.publishedDate = publishedDate
        self.imageURLString = imageURLString
    }
}
