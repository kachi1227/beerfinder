//
//  ShelfBeerCollectionItem.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
import UIKit

class ShelfBeerCollectionCell : UICollectionViewCell {
    
    @IBOutlet weak var nameBackdrop: UIView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleView.layer.borderColor = UIColor(string: "#B4B4B4").cgColor
        orderButton.setBackgroundImage(UIImage.imageWithColor(UIColor(string: "#000080"), forView:orderButton), for: .highlighted)
        detailsButton.setBackgroundImage(UIImage.imageWithColor(UIColor(string: "#cccccc"), forView: detailsButton), for: .highlighted)
        
        let nameGradient = CAGradientLayer()
        nameGradient.colors = [UIColor(string: "#99999950").cgColor, UIColor(string: "#99999990").cgColor]
        nameGradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        nameGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        nameBackdrop.layer.insertSublayer(nameGradient, at: 0)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded() //forces things to be resized
        adjustBackdropShadowsIfNeeded() //need to put this here, because prepareForReuse ONLY called when reusing
    }
    
    fileprivate func adjustBackdropShadowsIfNeeded() {
        let nameGradient = nameBackdrop.layer.sublayers![0] as! CAGradientLayer
        let nameGradientFrame = nameGradient.frame
        if nameGradientFrame.width != name.frame.width || nameGradientFrame.height != name.frame.height {
            nameGradient.frame = CGRect(x: 0.0, y: 0.0, width: name.frame.size.width, height: name.frame.size.height)
        }
        
    }
}
