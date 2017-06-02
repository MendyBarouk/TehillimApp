//
//  SwitchAnimation.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 22/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class SwitchAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var isReverse: Bool = false
    var duration = 0.2
    

    
    // This is used for percent driven interactive transitions, as well as for
    // container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let fromView = fromVC.view,
            let toView = toVC.view else {
                return
        }
        
        animateTransition(using: transitionContext, fromView: fromView, toView: toView)
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning, fromView: UIView, toView: UIView) {
        
        // Add the toView to the tab bar view
        fromView.superview!.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width;
        if let pre = Locale.current.languageCode, pre == "he" {
            isReverse = !isReverse
        }
        let offset = (isReverse ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        
        UIView.animate(withDuration: duration, animations: {
            
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y);
            toView.center   = CGPoint(x: toView.center.x - offset, y: toView.center.y);
            
        }, completion: { _ in
            
            let transitionFinished = !transitionContext.transitionWasCancelled
            
            if transitionFinished {
                fromView.removeFromSuperview()
                
            } else {
                fromView.frame = transitionContext.containerView.bounds;
            }
            transitionContext.completeTransition(transitionFinished)
            
        })
    }
}
