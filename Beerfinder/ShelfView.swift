//
//  ShelfReusableView.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
import UIKit

class ShelfView : UICollectionReusableView {
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    fileprivate func initViews() {
        self.backgroundColor = UIColor.red//UIColor(patternImage: UIImage(named: "metal_shelf_background.jpeg")!)
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createShadowPath()
        layoutIfNeeded() //forces things to be resized
    }
    
    fileprivate func createShadowPath() {
        let shadowPathOffset: CGFloat = 5
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: shadowPathOffset))
        path.addLine(to: CGPoint(x: 0, y: bounds.height + shadowPathOffset))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height + shadowPathOffset))
        path.addLine(to: CGPoint(x: bounds.width, y: shadowPathOffset))
        path.addLine(to: CGPoint(x: bounds.width/2, y: bounds.height/2))
        path.close()
    }
}
