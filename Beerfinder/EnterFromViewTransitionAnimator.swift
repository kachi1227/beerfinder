//
//  EnterFromViewTransitionAnimator.swift
//  Mask
//
//  Created by Kachi Nwaobasi on 5/10/15.
//  Copyright (c) 2015 Kachi Nwaobasi. All rights reserved.
//

import Foundation
import UIKit

class EnterFromViewTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    var presenting: Bool
    var startFrame: CGRect!
    var endFrame: CGRect!
    
    convenience init(startFrame: CGRect, endFrame: CGRect) {
        self.init(startFrame: startFrame, endFrame: endFrame, presenting: false)
    }
    
    init(startFrame: CGRect, endFrame: CGRect, presenting: Bool) {
        self.startFrame = startFrame
        self.endFrame = endFrame
        self.presenting = presenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentingView = presenting ? transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)! : transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let presentedView = presenting ? transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)! : transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!

        presentedView.view.frame = endFrame!
        
        if presenting {
            presentingView.view.isUserInteractionEnabled = false
            transitionContext.containerView.addSubview(presentedView.view)
            
            let scale = CGAffineTransform(scaleX: startFrame.width/endFrame.width, y: startFrame.height/endFrame.height)
            let transform = CGAffineTransform(translationX: startFrame.midX - endFrame.midX, y: startFrame.midY - endFrame.midY)
            presentedView.view.transform = scale.concatenating(transform)
            presentedView.view.alpha = 0.75
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                presentedView.view.transform = CGAffineTransform.identity
                presentedView.view.alpha = 1
                }, completion: {
                    _ in
                    transitionContext.completeTransition(true)
            })
            
        } else {
            presentingView.view.isUserInteractionEnabled = true
            transitionContext.containerView.bringSubview(toFront: presentedView.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                let scale = CGAffineTransform(scaleX: self.startFrame.width/self.endFrame.width, y: self.startFrame.height/self.endFrame.height)
                let transform = CGAffineTransform(translationX: self.startFrame.midX - self.endFrame.midX, y: self.startFrame.midY - self.endFrame.midY)
                presentedView.view.transform = scale.concatenating(transform)
                presentedView.view.alpha = 0.75
                }, completion: {
                    _ in
                    transitionContext.completeTransition(true)
            })
            
        }
    }
}

