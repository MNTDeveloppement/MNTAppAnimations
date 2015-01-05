//
//  TransitionController.swift
//  MNTApp
//
//  Created by Mehdi Sqalli on 30/12/14.
//  Copyright (c) 2014 MNT Developpement. All rights reserved.
//

import UIKit
import QuartzCore

class TransitionPresentationController: NSObject, UIViewControllerAnimatedTransitioning {
   
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
        
        // take a snapshot of the detail ViewController so we can do whatever with it (cause it's only a view), and don't have to care about breaking constraints
        let snapshotView = toViewController.view.resizableSnapshotViewFromRect(toViewController.view.frame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
        snapshotView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        snapshotView.center = fromViewController.view.center
        containerView.addSubview(snapshotView)
        
        // hide the detail view until the snapshot is being animated
        toViewController.view.alpha = 0.0
        containerView.addSubview(toViewController.view)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 20.0, options: nil,
            animations: { () -> Void in
                snapshotView.transform = CGAffineTransformIdentity
            }, completion: { (finished) -> Void in
                snapshotView.removeFromSuperview()
                toViewController.view.alpha = 1.0
                transitionContext.completeTransition(finished)
        })
//        storedContext = transitionContext
//        
//        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as FirstViewController
//        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as HomeViewController
//        
//        transitionContext.containerView().addSubview(toVC.view)
//        
//        // grow logo
//        
//        let animation = CABasicAnimation(keyPath: "transform")
//        
//        animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(8.0, 10.0, 1.0)
////            CATransform3DConcat(
//////                CATransform3DMakeTranslation(0.0, 0.0, 0.0),
////                CATransform3DMakeScale(15.0, 10.0, 10.0)
////            )
//        )
//        
//        animation.duration = animationDuration
//        animation.delegate = self
//        animation.fillMode = kCAFillModeForwards
//        animation.removedOnCompletion = false
//        delay(seconds: animationDuration) { () -> () in
//            fromVC.mntLogo.layer.removeAllAnimations()
//            //transitionContext.containerView().addSubview(toVC.view)
//        }
//        
//        fromVC.mntLogo.layer.addAnimation(animation, forKey: nil)
//        
//        toVC.logo.layer.opacity = 0.0
//        
////        let fadeIn = CABasicAnimation(keyPath: "opacity")
////        fadeIn.duration = animationDuration
////        fadeIn.toValue = 3.0
//        
////        toVC.logo.layer.addAnimation(fadeIn, forKey: "fadeIn")
////        toVC.logo.layer.addAnimation(animation, forKey: nil)
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if let context = storedContext {
//            let toVC = context.viewControllerForKey(UITransitionContextToViewControllerKey) as HomeViewController
//            toVC.logo.layer.opacity = 0
            context.completeTransition(!context.transitionWasCancelled())
        }
        
        storedContext = nil
        animating = false
    }
    
}
