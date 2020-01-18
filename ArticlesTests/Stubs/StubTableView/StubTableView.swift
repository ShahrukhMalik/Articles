//
//  StubTableView.swift
//  ArticlesDemoAppTests
//
//  Created by Shah Rukh Malik on 10/10/19.
//  Copyright © 2019 Shah Rukh Malik. All rights reserved.
//

import UIKit

class StubTableView: UITableView {

    var isdequeueCalled = false
    var cell:UITableViewCell?
    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        isdequeueCalled = true
        return super.dequeueReusableCell(withIdentifier: identifier)
    }
    

}
