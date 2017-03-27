//
//  PlaceOrderViewController
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/26/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class PlaceOrderViewController : UIViewController {
    
    var beer: TempBeer!
    var formatter : NumberFormatter!
    var totalValue: NSNumber! {
        didSet {
            self.total.text = "TOTAL: \(formatter.string(from: totalValue)!)"
        }
    }
    
    @IBOutlet weak var singleBeerImage: UIImageView!
    @IBOutlet weak var singleBeerStepper: UIEmbeddedNumberStepper!
    @IBOutlet weak var singleBeerPrice: UILabel!
    
    @IBOutlet weak var sixPackImage: UIImageView!
    @IBOutlet weak var sixPackPrice: UILabel!
    @IBOutlet weak var sixPackStepper: UIEmbeddedNumberStepper!

    @IBOutlet weak var twelvePackImage: UIImageView!
    @IBOutlet weak var twelvePackPrice: UILabel!
    @IBOutlet weak var twelvePackStepper: UIEmbeddedNumberStepper!
    
    @IBOutlet weak var total: UILabel!

    @IBOutlet weak var pickUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        configureViews()
    }
    
    fileprivate func configureViews() {
        singleBeerImage.image = UIImage(named: beer.sizes[0].image)
        singleBeerPrice.text = formatter.string(from: NSNumber(value: beer.sizes[0].price))
        singleBeerStepper.value = 1
        singleBeerStepper.delegate = self
        
        sixPackImage.image = UIImage(named: beer.sizes[1].image)
        sixPackPrice.text = formatter.string(from: NSNumber(value: beer.sizes[1].price))
        sixPackStepper.delegate = self
        
        twelvePackImage.image = UIImage(named: beer.sizes[2].image)
        twelvePackPrice.text = formatter.string(from: NSNumber(value: beer.sizes[2].price))
        twelvePackStepper.delegate = self
        
        
        pickUpButton.setBackgroundImage(UIImage.imageWithColor(UIColor(string: "#999999"), forView: pickUpButton), for: .highlighted)

        
        updateTotal()
    }
    
    @IBAction func pickupTapped(_ sender: Any) {
        let orderRef = FIRDatabase.database().reference().child("order")
        let quantityString = "\(sixPackStepper.value) six packs"
        let name = beer.name ?? "placeHolder"
        orderRef.setValue(["name" : name, "quantity": quantityString])
        
        navigationController?.popViewController(animated: true)
    }
}

extension PlaceOrderViewController : UIEmbeddedNumberStepperDelegate {
    func valueDecremented() {
        updateTotal()
    }
    
    func valueIncremented() {
        updateTotal()
    }
    
    fileprivate func updateTotal() {
        let singleTotal = beer.sizes[0].price * Double(singleBeerStepper.value)
        let sixPackTotal = beer.sizes[1].price * Double(sixPackStepper.value)
        let twelvePackTotal = beer.sizes[2].price * Double(twelvePackStepper.value)
        totalValue = NSNumber(value: singleTotal + sixPackTotal + twelvePackTotal)
    }
}
