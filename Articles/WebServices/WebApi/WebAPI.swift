//
//  WebAPI.swift
//  ArticlesDemoApp
//
//  Created by Shahrukh Malik on 9/8/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import Foundation

typealias onCompletion = (Any?, NetworkError?)->()

public enum URLMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
    case PATCH
}


protocol WebAPIHandler {
    func getDataFromServer( url: String, withMethod method: URLMethod?,completion: @escaping onCompletion) -> URLSessionTask?
}
