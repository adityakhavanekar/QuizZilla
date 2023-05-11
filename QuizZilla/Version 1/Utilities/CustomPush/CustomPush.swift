//
//  CustomPush.swift
//  QuizZilla
//
//  Created by APPLE on 11/05/23.
//

import Foundation
import UIKit

class CustomPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else {
                return
        }
        
        // Add the new view controller's view to the container
        transitionContext.containerView.addSubview(toViewController.view)
        
        // Set up the initial state for the animation
        toViewController.view.transform = CGAffineTransform(translationX: transitionContext.containerView.bounds.size.width, y: 0)
        
        // Animate the transition
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.transform = CGAffineTransform(translationX: -transitionContext.containerView.bounds.size.width, y: 0)
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { finished in
            fromViewController.view.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

}




