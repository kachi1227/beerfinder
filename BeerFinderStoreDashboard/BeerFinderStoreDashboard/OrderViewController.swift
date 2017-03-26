//
//  ViewController.swift
//  BeerFinderStoreDashboard
//
//  Created by Henry Dinhofer on 3/26/17.
//  Copyright © 2017 Henry Dinhofer. All rights reserved.
//

import UIKit
import Firebase
import M13Checkbox

class OrderViewController: UIViewController {

    var screenWidth : CGFloat = 0
    var screenHeight : CGFloat = 0
    
    @IBOutlet weak var orderLabel: UILabel!
    
    var orderView : UIView!
    var productLabel : UILabel!
    var quantityLabel : UILabel!
    var orderDueLabel : UILabel!
    var orderNumber: UILabel!
    
    var secondTime = false
    var checkbox : M13Checkbox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        screenWidth = self.view.bounds.size.width
        screenHeight = self.view.bounds.size.height
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.56, green: 0.12, blue: 0.16, alpha: 1.0) //255.0
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.56, green: 0.12, blue: 0.16, alpha: 1.0) //255.0
        
        let ABInBevLogo = UIImageView.init(image:#imageLiteral(resourceName: "ABInBevLogo"))
        ABInBevLogo.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        ABInBevLogo.contentMode = .scaleAspectFit
        navigationItem.titleView = ABInBevLogo

        
        orderView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        
        let newLabel = UILabel(frame: CGRect(x: 18.8, y: 65, width: 376.4, height: 52))
        //newLabel.font = UIFont(name: ".SFNSText-Light", size: 30.0) // "SFNSText-Light"
        newLabel.font = UIFont(name: "AvenirNext-Regular", size: 44.3)
        newLabel.text = "New Order"
        newLabel.textAlignment = .center
        newLabel.textColor = UIColor.black
        orderView.addSubview(newLabel)
        
        let greySeparator = UIView(frame: CGRect(x: 22.6, y: 117.8, width: 372.6, height: 3.7))
        greySeparator.backgroundColor = UIColor(colorLiteralRed: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0)
        orderView.addSubview(greySeparator)
        
        let product = UILabel(frame: CGRect(x: 115, y: 138, width: 184, height: 44))
        product.textAlignment = .center
        product.textColor = UIColor.black
        product.font = UIFont(name: "Arial", size: 36.9)
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Product", attributes: underlineAttribute)
        product.attributedText = underlineAttributedString
        //  SFNSText-Semibold  size: 36.9pt
        orderView.addSubview(product)
        
        
        let quantity = UILabel(frame: CGRect(x: 117, y: 255, width: 184, height: 44))
        quantity.font = UIFont(name: "Arial", size: 36.9)
        quantity.textAlignment = .center
        quantity.textColor = UIColor.black
        let ua = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let uas = NSAttributedString(string: "Quantity", attributes: ua)
        quantity.attributedText = uas
        orderView.addSubview(quantity)

        let orderDue = UILabel(frame: CGRect(x: 94, y: 371, width: 227.4, height: 44))
        orderDue.font = UIFont(name: "Arial", size: 36.9)
        orderDue.text = "New Order"
        orderDue.textAlignment = .center
        orderDue.textColor = UIColor.black
        let ua1 = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let uas1 = NSAttributedString(string: "Order Due", attributes: ua1)
        orderDue.attributedText = uas1

        
        orderView.addSubview(orderDue)
        
        let orderNum = UILabel(frame: CGRect(x: 93, y: 488, width: 227.4, height: 44))
        orderNum.font = UIFont(name: "Arial", size: 36.9)
        orderNum.textAlignment = .center
        orderNum.textColor = UIColor.black
        let ua2 = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let uas2 = NSAttributedString(string: "Order #", attributes: ua2)
        orderNum.attributedText = uas2

        orderView.addSubview(orderNum)
        
        
        productLabel = UILabel(frame: CGRect(x: 117, y: 182, width: 184, height: 35))
        productLabel.font = UIFont(name: "AvenirNext-Regular", size: 29.5)
        productLabel.textAlignment = .center
        productLabel.textColor = UIColor.black
        productLabel.text = "placeholder"
        orderView.addSubview(productLabel)
        
        quantityLabel = UILabel(frame: CGRect(x: 117, y: 299, width: 184, height: 35))
        quantityLabel.font = UIFont(name: "AvenirNext-Regular", size: 29.5)
        quantityLabel.textAlignment = .center
        quantityLabel.textColor = UIColor.black
        quantityLabel.text = "placeholder"
        orderView.addSubview(quantityLabel)

        orderDueLabel = UILabel(frame: CGRect(x: 75, y: 415, width: 300, height: 35))
        orderDueLabel.font = UIFont(name: "AvenirNext-Regular", size: 29.5)
        orderDueLabel.textAlignment = .center
        orderDueLabel.textColor = UIColor.black
        orderDueLabel.text = "ASAP"
        orderView.addSubview(orderDueLabel)
        
        orderNumber = UILabel(frame: CGRect(x: 94, y: 532, width: 227.4, height: 35))
        orderNumber.font = UIFont(name: "AvenirNext-Regular", size: 29.5)
        orderNumber.textAlignment = .center
        orderNumber.textColor = UIColor.black
        orderNumber.text = "12345678"
        orderView.addSubview(orderNumber)
        
        let bottomCheckmark = UIButton(frame: CGRect(x: 143, y: 591, width: 128, height: 128))
        bottomCheckmark.setImage(#imageLiteral(resourceName: "checkIcon"), for: .normal)
        bottomCheckmark.imageView?.contentMode = .scaleAspectFit
        bottomCheckmark.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        orderView.addSubview(bottomCheckmark)
        
        view.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        orderView.isHidden = true
        
        
        view.addSubview(orderView)
        
        
        
//        let orderRef = FIRDatabase.database().reference().child("order")
//        orderRef.setValue(["name": "Bud-Light", "quantity": "2 six pack" ])
        
        observePrice()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkTapped() {
        
        orderView.isHidden = true
        animateCheckmark()
        //checkbox.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.orderLabel.isHidden = false
            self.view.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
            self.checkbox.isHidden = true
        }
        
        print("checkTapped")
    }
    func animateCheckmark() {
        view.backgroundColor = UIColor.green
        
        let size = CGFloat(250.0)
        let offset = size / 2
        checkbox = M13Checkbox(frame: CGRect(x: self.view.frame.midX - offset, y: self.view.frame.midY - offset, width: size, height: size))
        //checkbox.stateChangeAnimation = .spiral
        checkbox.stateChangeAnimation = .expand(.fill)
        checkbox.animationDuration = 2.0  //5.0
        //checkbox.checkState = .unchecked
        //checkbox.markType = .radio
        checkbox.boxType = .circle
        checkbox.tintColor = UIColor.white  // spiral: white,  white
        checkbox.secondaryTintColor = UIColor.white  // spiral: black, white
        checkbox.secondaryCheckmarkTintColor = UIColor.green // spiral:white, green
        checkbox.boxLineWidth = 4.0
        checkbox.checkmarkLineWidth = 10.0
        //checkbox.stateChangeAnimation = .dot(M13Checkbox.AnimationStyle.fill)
        //checkbox.setCheckState(.checked, animated: true)
        //checkbox.toggleCheckState(true)
        //checkbox.toggleCheckState(true)
        checkbox.setCheckState(.checked, animated: true)
        self.view.addSubview(checkbox)
        //checkbox.setCheckState(M13Checkbox.CheckState.checked, animated: true)
    }
    

    func observePrice() {
        let orderRef = FIRDatabase.database().reference().child("order")
        
        let callback = orderRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            // ...
            
            //if let price = snapshot.value as? NSNumber {
            if let order = snapshot.value as? NSDictionary {
                // price changed
                //self.priceTextView.text = "\(price)"
                
                print("price is now \(order)")
                let name = order["name"] as? String ?? "placeHolder"
                let quantity = order["quantity"] as? String ?? "placeHolder"
                
                let now = Date()
                
                if self.secondTime {
                    self.productLabel.text = name
                    self.quantityLabel.text = quantity
                    self.orderDueLabel.text = now.bestDate()
                    self.orderLabel.isHidden = true
                    self.orderView.isHidden = false

                } else {
                    self.secondTime = true
                }
                
                
                //local notification
                
                
                // add the timestamp to a list of timestamps
                //     then we'll make timestamp happen on a 'bump'
                
                
                
                // cool animation to change price label
                
                
                
            } else {
                print("Unable to capture changed value from db")
            }
            
            
        })
        
        
    }

    
}

extension Date {
    //MARK: - Day + Time
    /**
     Converts NSDate and returns a formatted string with day and time.
     
     - Returns: String e.g. "Sunday, 7:01 AM"
     
     */
    func bestDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, h:mm a"
        let dateString = formatter.string(from: self)
        
        return dateString
    }

}
