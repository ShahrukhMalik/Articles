//
//  String+Extension.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

extension String {
    
    static func formattedDateFromDateString(dateString : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:dateString)!
        return formattedStringFromDate(date: date)
    }
    
    static func formattedStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: date)
    }
}
