//
//  BeerDetailsViewController.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
import UIKit

class BeerDetailsViewController : UIViewController {

    var beer: TempBeer!
    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var manufacturer: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var introduced: UILabel!
    @IBOutlet weak var alcoholVolume: UILabel!
    
    
    @IBOutlet weak var orderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    fileprivate func configureViews() {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: beer.name + " Details:")
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        titleView.attributedText = attributeString
        type.text = beer.type
        manufacturer.text = beer.manufacturer
        origin.text = beer.cityOfOrigin ?? ""
        introduced.text = beer.introduced == nil ? "" : "\(beer.introduced!)"
        alcoholVolume.text = "\(beer.alcoholByVolume!)"
        
        orderButton.setBackgroundImage(UIImage.imageWithColor(UIColor(string: "#999999"), forView: orderButton), for: .highlighted)
    }
    
    @IBAction func xTapped(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func orderTapped(_ sender: Any) {
        let viewController = presentingViewController
        presentingViewController?.dismiss(animated: true, completion: {
            self.launchPlaceOrderViewController(viewController: viewController!)
        })
    }
    
    private func launchPlaceOrderViewController(viewController: UIViewController) {
        let placeOrderViewController = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderViewController") as! PlaceOrderViewController
        placeOrderViewController.beer = beer
        (viewController as! UINavigationController).pushViewController(placeOrderViewController, animated: true)
    }
}
