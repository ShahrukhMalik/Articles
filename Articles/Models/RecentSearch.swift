//
//  RecentSearch.swift
//  Articles
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

class RecentSearchModel {
    let term: String
    let date: Date
    
    init(aTerm: String, aDate: Date) {
        self.term = aTerm
        self.date = aDate
    }
}
