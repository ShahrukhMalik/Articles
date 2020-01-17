//
//  DownloaderImageView.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    
    static let shared = ImageCache()
    
    private init() {
        // make sure to purge cache on memory pressure
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer!)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

@objc class DownloaderImageView: UIImageView {
    
    private static var taskKey = 0
    private static var urlKey = 0
    
    @objc func loadImageUsingUrlString(urlString: String?) {
        
        // reset imageview's image
        self.image = UIImage(named: "Placeholder")
        
        // allow supplying of `nil` to remove old image and then return immediately
        guard let urlString = urlString else { return }
        
        print("Image URL STRING : \(urlString)")
        
        // check cache
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        // download
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            //error handling
            if let error = error {
                // don't bother reporting cancelation errors
                if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorCancelled {
                    return
                }
                
                print(error)
                return
            }
            
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("unable to extract image")
                return
            }
            
            ImageCache.shared.save(image: downloadedImage, forKey: urlString)
            
            DispatchQueue.main.async {
                self?.image = downloadedImage
            }
        }
        
        task.resume()
    }
}
