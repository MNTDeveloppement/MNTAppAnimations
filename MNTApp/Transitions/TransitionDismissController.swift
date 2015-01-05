//
//  TransitionDismissController.swift
//  MNTApp
//
//  Created by Mehdi Sqalli on 30/12/14.
//  Copyright (c) 2014 MNT Developpement. All rights reserved.
//

import UIKit
import QuartzCore

class TransitionDismissController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 1.0
    
    var animating = false
    var operation:UINavigationControllerOperation = .Push
    
    weak var storedContext: UIViewControllerContextTransitioning? = nil
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return animationDuration
        
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        let animationDuration = self .transitionDuration(transitionContext)
        
        let snapshotView = fromViewController.view.resizableSnapshotViewFromRect(fromViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        snapshotView.center = toViewController.view.center
        containerView.addSubview(snapshotView)
        
        fromViewController.view.alpha = 0.0
        
        let toViewControllerSnapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        containerView.insertSubview(toViewControllerSnapshotView, belowSubview: snapshotView)
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1)
            snapshotView.alpha = 0.0
            }) { (finished) -> Void in
                toViewControllerSnapshotView.removeFromSuperview()
                snapshotView.removeFromSuperview()
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
//        storedContext = transitionContext
//        
//        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as HomeViewController
//        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as FirstViewController
//        
//        transitionContext.containerView().insertSubview(toVC.view, belowSubview: fromVC.view)
//        
//        UIView.animateWithDuration(animationDuration, animations: {
//            toVC.view.backgroundColor = .redColor()
////            fromVC.view.transform = CGAffineTransformMakeScale(0.01, 0.01)
//            }, completion: {_ in
//                toVC.view.removeFromSuperview()
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
//                
//                self.storedContext = nil
//                self.animating = false
//        })
    }
}
