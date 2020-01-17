//
//  ServiceApi.swift
//  ArticlesDemoApp
//
//  Created by Shahrukh Malik on 9/8/19.
//  Copyright © 2019 Shahrukh Malik. All rights reserved.
//

import Foundation



public class ServiceApi:WebAPIHandler {
    
    
    static let shared = ServiceApi()
    
    var task: URLSessionTask!
    var session = URLSession.shared

    func getDataFromServer(url: String, withMethod method: URLMethod?, completion: @escaping onCompletion) -> URLSessionTask? {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, NetworkError.noNetwork)
            return nil
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        
        
        if let urL = URL(string: urlString) {
            var request = URLRequest(url: urL)
            if let method = method {
                request.httpMethod = method.rawValue
            }
            
          
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion,error: error)
            }
            task.resume()
            return task
        }
        return nil
    }
    
    
   
    
    func getData(url: String, withMethod method: URLMethod?,completion: @escaping onCompletion) {
        task = getDataFromServer(url: url, withMethod: method) {(data, error) in
            
            guard error == nil else {
                completion(nil,error)
                return
            }
            completion(data,error)
        }
    }
    
    func cancelRequest() {
        self.task.cancel()
    }
    
    
}
