//
//  EnterFromViewPresentationController.swift
//  Mask
//
//  Created by Kachi Nwaobasi on 5/12/15.
//  Copyright (c) 2015 Kachi Nwaobasi. All rights reserved.
//

import Foundation
import UIKit
import TSMessages

@objc protocol EnterFromViewPresentationDelegate : NSObjectProtocol {
    @objc optional func prepareForPresentationTransition()
    @objc optional func presentationTransitionDidBegin()
    @objc optional func presentationTransitionDidEnd()
    @objc optional func prepareForDismissalTransition()
    @objc optional func dismissalTransitionDidBegin()
    @objc optional func dismissalTransitionDidEnd()
}
class EnterFromViewPresentationController : UIPresentationController, TSMessageViewProtocol {
    
    var backgroundView : UIView!
    weak var enterDelegate: EnterFromViewPresentationDelegate?
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        initialize()
    }
    
    fileprivate func initialize() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EnterFromViewPresentationController.dimmingViewTapped(_:))))
    }
    
    func dimmingViewTapped(_ sender : AnyObject) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    override func presentationTransitionWillBegin() {
        backgroundView.frame = containerView!.bounds
        
        containerView!.addSubview(backgroundView)
        containerView!.addSubview(presentedView!)
        
        if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.prepareForPresentationTransition)) {
            self.enterDelegate!.prepareForPresentationTransition!()
        }
        
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: {
            context in
            if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.presentationTransitionDidBegin)) {
                self.enterDelegate!.presentationTransitionDidBegin!()
            }
            return
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            backgroundView.removeFromSuperview()
            if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.dismissalTransitionDidBegin)) {
                self.enterDelegate!.dismissalTransitionDidBegin!()
            }
        } else {
            if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.presentationTransitionDidEnd)) {
                self.enterDelegate!.presentationTransitionDidEnd!()
            }
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.prepareForDismissalTransition)) {
            self.enterDelegate!.prepareForDismissalTransition!()
        }
        let transitionCoordindator = presentingViewController.transitionCoordinator
        transitionCoordindator?.animate(alongsideTransition: {
            context in
            if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.dismissalTransitionDidBegin)) {
                self.enterDelegate!.dismissalTransitionDidBegin!()
            }
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backgroundView.removeFromSuperview()
            if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.dismissalTransitionDidEnd)) {
                self.enterDelegate!.dismissalTransitionDidEnd!()
            }
        } else { //if it didn't complete, undo whatever we may have done
            if self.enterDelegate != nil && self.enterDelegate!.responds(to: #selector(EnterFromViewPresentationDelegate.presentationTransitionDidBegin)) {
                self.enterDelegate!.presentationTransitionDidBegin!()
            }
        }
    }
    
    func customize(_ messageView: TSMessageView) {
        messageView.removeFromSuperview()
        containerView!.addSubview(messageView)
    }
}
