//
//  TransitionDelegate.swift
//  MNTApp
//
//  Created by Mehdi Sqalli on 30/12/14.
//  Copyright (c) 2014 MNT Developpement. All rights reserved.
//

import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentationAnimator = TransitionPresentationController()
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let dismissalAnimator = TransitionDismissController()
        return dismissalAnimator
    }
}