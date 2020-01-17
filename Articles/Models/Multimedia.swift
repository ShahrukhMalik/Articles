//
//  Multimedia.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

class Multimedia: Codable {
    let url: String
    let height, width: Int
    
    enum CodingKeys: String, CodingKey {
        case url, height, width
    }
    
    init(url: String, height: Int, width: Int) {
        self.url = url
        self.height = height
        self.width = width
    }
}
