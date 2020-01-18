//
//  Search+CoreDataProperties.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {
    @NSManaged public var date: NSDate?
    @NSManaged public var term: String?
}
