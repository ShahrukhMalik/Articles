//
//  StubMultimedia.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

@testable import Articles
class StubMultimedia: Multimedia {
    
    static func dummyMultimedia() -> Multimedia  {
        return Multimedia(url: "URL", height: 10, width: 10)
    }
}
