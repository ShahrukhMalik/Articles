//
//  UIColor+Extension.swift
//  Articles
//
//  Created by Shahrukh Malik on 10/10/19.
//  Copyright © 2019 Shah Rukh. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}
