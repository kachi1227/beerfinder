//
//  BaseUILabel.swift
//  Mask
//
//  Created by Kachi Nwaobasi on 2/26/15.
//  Copyright (c) 2015 Kachi Nwaobasi. All rights reserved.
//

import Foundation
import UIKit

class BaseUILabel : UILabel {
    
    @IBInspectable var topInset : CGFloat = 0
    @IBInspectable var leftInset : CGFloat = 0
    @IBInspectable var bottomInset : CGFloat = 0
    @IBInspectable var rightInset : CGFloat = 0

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, insets), limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        
        return rect
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}
