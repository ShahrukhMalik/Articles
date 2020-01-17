//
//  Headline.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

class Headline: Codable {
    let main: String
    let printHeadline: String?
    
    enum CodingKeys: String, CodingKey {
        case main
        case printHeadline = "print_headline"
    }
    
    init(main: String, printHeadline: String?) {
        self.main = main
        self.printHeadline = printHeadline
    }
}
