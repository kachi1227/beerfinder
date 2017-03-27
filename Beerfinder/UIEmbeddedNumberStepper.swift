//
//  UIEmbeddedNumberStepper.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/26/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
protocol UIEmbeddedNumberStepperDelegate : class {
    func valueIncremented()
    func valueDecremented()
}
class UIEmbeddedNumberStepper : UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var number: UILabel!
    
    
    @IBInspectable var minValue: Int = Int.min
    @IBInspectable var maxValue: Int = Int.max
    
    var value: Int = 0 {
        didSet {
            number.text = "\(value)"
        }
    }
    
    weak var delegate: UIEmbeddedNumberStepperDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Bundle.main.loadNibNamed("UIEmbeddedNumberStepper", owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[contentView]-0-|", options: [], metrics: nil, views: ["contentView" : contentView])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[contentView]-0-|", options: [], metrics: nil, views: ["contentView" : contentView])
        addConstraints(constraints)
        
        number.text = "\(value)"
    }

    
    
    @IBAction func decrementTapped(_ sender: Any) {
        let newValue = value - 1
        value = min(max(newValue, minValue), maxValue)
        delegate?.valueDecremented()
    }
    
    @IBAction func incrementTapped(_ sender: Any) {
        let newValue = value + 1
        value = min(max(newValue, minValue), maxValue)
        delegate?.valueIncremented()
    }
    
    
}
