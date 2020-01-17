//
//  NetworkError.swift
//  ArticlesDemoApp
//
//  Created by Shahrukh Malik on 9/8/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import Foundation


enum NetworkError: Error {
    case noNetwork
    case parsingError(String)
    case unknown(String)
    case other(String)
}

extension NetworkError: LocalizedError {
    
    var localizedDescription : String {
        
        switch self {
        case .noNetwork:
            return "Please check your internet connection."
        case .parsingError(let error):
            return error
        case .unknown(let error):
            return error
        case .other(let error):
            return error
        }
    }
}
