//
//  UINavigationBarTitleView.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/26/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation

class UINavigationBarTitleView : UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var imageLeadingConstraints: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    fileprivate func loadView() {
        Bundle.main.loadNibNamed("UINavigationBarTitleView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[contentView]-0-|", options: [], metrics: nil, views: ["contentView" : contentView])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[contentView]-0-|", options: [], metrics: nil, views: ["contentView" : contentView])
        addConstraints(constraints)
    }
}
