//
//  ViewController.swift
//  Beerfinder
//
//  Created by Kachi Nwaobasi on 3/25/17.
//  Copyright © 2017 Ranger Bud. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class ViewController: UIViewController  {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn() // NEW

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


// MARK: Sign in with Google
extension ViewController : GIDSignInUIDelegate, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            let authentication : GIDAuthentication = user.authentication
            let credential : FIRAuthCredential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            
            FIRAuth.auth()?.signIn(with: credential, completion: { (user : FIRUser?, error) in
                if let user = user {
                    
                    print("Welcome to beerfinder you've signed in!")
                    self.signInButton.isEnabled = false
                    self.performSegue(withIdentifier: "loginToBeerSelection", sender: self)
                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
//                        self.performSegue(withIdentifier: "loginToBeerSelection", sender: self)
//                    })

                    
                }
                else {
                    print("Error signing in %@", error.debugDescription)
                }
            })
            
        } else {
            print("Error signing in \(error.localizedDescription)")
        }
    }

}
