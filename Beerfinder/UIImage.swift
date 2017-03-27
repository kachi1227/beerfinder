//
//  UIImage.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation

extension UIImage {
    
    class func imageWithColor(_ color : UIColor, forView view: UIView) -> UIImage {
        view.layoutIfNeeded()
        return imageWithColor(color, andSize: view.bounds.size)
    }
    
    class func imageWithColor(_ color: UIColor, andSize size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
