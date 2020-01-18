//
//  StubDownloaderImageView.swift
//  ArticlesTests
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import XCTest

@testable import Articles

class StubDownloaderImageView: DownloaderImageView {
    
    var isLoadImageURLCalled = false
    
    override func loadImageUsingUrlString(urlString: String?) {
        isLoadImageURLCalled = true
    }
}
