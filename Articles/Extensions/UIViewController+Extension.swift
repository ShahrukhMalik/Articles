//
//  UIViewController+Extension.swift
//  Articles
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
