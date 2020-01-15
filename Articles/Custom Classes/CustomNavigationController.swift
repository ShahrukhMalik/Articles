//
//  CustomNavigationController.swift
//  Articles
//
//  Created by Shahrukh Malik on 1/15/20.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.applyShadowToNavigationBar()
    }
    
    
    // MARK :- Private methods
    
    private func applyShadowToNavigationBar() {
        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationBar.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.navigationBar.layer.shadowRadius = 4.0
        self.navigationBar.layer.shadowOpacity = 0.5
    }
}
